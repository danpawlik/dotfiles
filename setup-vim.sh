#!/bin/bash

CONFIGURE_VIM=${CONFIGURE_VIM:-true}
VIM_CONFIG="${VIM_CONFIG:-ycm}"
SETUP_NEOVIM="${SETUP_NEOVIM:-true}"
SOURCE_DIR=${SOURCE_DIR:-'/tmp/dotfiles'}
YCM_FLAGS=${YCM_FLAGS:-'--clang-completer'}

OS_VERSION=$(awk '{print $4}' /etc/centos-release | cut -f1 -d'.')
if [ -z "${OS_VERSION}" ]; then
    OS_VERSION="None"
fi

# NOTE: if you want to use 'coc' vim setup, you need to install neovim.
if [ "${SETUP_NEOVIM}" = "true" ]; then
    curl -L "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -o /tmp/nvim.appimage
    cd /tmp ; chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract && cd -
    mkdir -p "$HOME/.local"
    mv /tmp/squashfs-root "$HOME/.local/nvim"
    NVIM_PATH="$HOME/.local/nvim/usr/bin/nvim"

    if echo "$SHELL" | grep -q 'zsh'; then
        echo "alias vim=\"$NVIM_PATH\"" >> "${HOME}/.zshrc"
        echo "alias vimdiff=\"$NVIM_PATH -d\"" >> "${HOME}/.zshrc"
        source "$HOME/.zshrc"
    elif echo "$SHELL" | grep -q 'bash'; then
        echo "alias vim=\"$NVIM_PATH\"" >> "${HOME}/.bashrc"
        echo "alias vimdiff=\"$NVIM_PATH -d\"" >> "${HOME}/.bashrc"
        source "$HOME/.bashrc"
    else
        echo "Add: alias vim=$NVIM_PATH into your shell rc file"
    fi

    alias nvim=$NVIM_PATH
    alias vim=nvim
    mkdir -p "${HOME}/.config/nvim"
    ln -s "${HOME}/.vimrc" "${HOME}/.config/nvim/init.vim"

    curl -fLo "${HOME}/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ "$CONFIGURE_VIM" = "true" ]; then
    if [ "${VIM_CONFIG}" == 'spacevim' ]; then
        curl -sLf https://spacevim.org/install.sh | bash
        cp -avf "${SOURCE_DIR}/.SpaceVim.d" ~/.SpaceVim.d
        exit 0
    fi

    mkdir -p ~/.vim/
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # This script is designed to be done as user, not root, but it will
    # work on both.
    if ! command -v sudo ; then
        yum install -y sudo
    fi

    if ! command -v git ; then
        sudo yum install -y git
    fi

    if ! [ -d "${SOURCE_DIR}" ]; then
        git clone https://github.com/danpawlik/dotfiles.git "${SOURCE_DIR}"
    fi

    if ! command -v pip || ! command -v pip3 || ! command -v pip-3 ; then
        # sudo apt install -y python-pip python3-pip || sudo yum install -y python3-pip
        curl -SL https://bootstrap.pypa.io/get-pip.py | sudo python3
    fi

    if [ "${VIM_CONFIG}" == 'ycm' ]; then
        sudo yum install -y automake gcc gcc-c++ kernel-devel cmake make python3-devel

        if [[ $OS_VERSION -eq 7 ]]; then
            sudo yum check-update
            sudo yum install -y devtoolset-8 centos-release-scl cmake scl-utils
        fi

        if [ "${YCM_FLAGS}" == '--all' ]; then
            # NOTE: drop support for Debian/Ubuntu
            sudo yum install -y golang
            if ! command -v npm ; then
                curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
                sudo yum install -y nodejs
            fi
        fi
    fi

    if [ "${VIM_CONFIG}" == 'jedi' ]; then
        sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi python3-setuptools
    fi

    if [ "${VIM_CONFIG}" == 'coc' ]; then
        if ! command -v npm ; then
            echo "Setup NodeJS"
            export LC_ALL=en_US.UTF-8
            # NOTE: it install lts nodejs version without prompt
            # bash <(curl -sL install-node.now.sh/lts ) -f
            curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
            sudo yum install -y nodejs
        fi
    fi


    ##### CONFIGURATION #####


    echo "Copy main vimrc file"
    for f in general.vim plugins_conf.vim plugins.vim; do
        cp -vf "${SOURCE_DIR}/vimrc/${f}" "$HOME/.vim/"
    done
    cp -vf "${SOURCE_DIR}/vimrc/init.vim" "$HOME/.vimrc"
    cp -av "${SOURCE_DIR}/vimrc/plugin_conf" "$HOME/.vim/"

    # Uncomment just desired plugin in vimrc; it will ignore YouCompleteMe
    sed -i "/^\".*\/${VIM_CONFIG}/s/^\"//" "$HOME/.vimrc"

    # Uncomment just desired plugin in plugins file
    sed -i "/^\".*\/${VIM_CONFIG}/s/^\"//" "$HOME/.vim/plugins.vim"

    echo "Installing vim plugins..."
    $NVIM_PATH +PlugInstall +qall &> /dev/null || vim +PlugInstall +qall &> /dev/null

    if [ "${VIM_CONFIG}" == 'ycm' ]; then
        # Uncomment YouCompleteMe
        sed -i "/^\".*\/YouCompleteMe/s/^\"//" "$HOME/.vimrc"

        echo "Compiling YCM"
        if [[ $OS_VERSION -eq 7 ]]; then
            scl enable devtoolset-8 - << \EOF
$HOME/.vim/plugged/YouCompleteMe/install.py ${YCM_FLAGS}
EOF
        else
            "$HOME/.vim/plugged/YouCompleteMe/install.py"
        fi
    fi

    if [ "${VIM_CONFIG}" == 'coc' ]; then
        echo "Setup COC plugins"
        pip3 install --user jedi pylint
        PLUGINS='CocInstall -sync coc-snippets coc-fzf coc-sh coc-json coc-utils coc-pyright coc-html coc-yaml coc-prettier coc-python coc-git coc-go coc-docker|q'
        # For web development
        #vim -c 'CocInstall -sync coc-react-refactor coc-reason coc-snippets coc-highlight coc-prettier coc-html-css-support coc-react-refactor coc-reason coc-rescript|q'
        $NVIM_PATH -c $PLUGINS || vim -c $PLUGINS
        echo "You can also install other modules by installing: :CocInstall coc-marketplace and choose your own with: :CocList marketplace"
    fi

    # Other packages required by Ale
    pip3 install --user neovim mypy pynvim rstcheck proselint \
                        gitlint mypy ansible-lint black yapf vim-vint yamllint
    sudo npm install -g prettier eslint
    sudo yum install -y shellcheck ocaml-merlin || true
fi
