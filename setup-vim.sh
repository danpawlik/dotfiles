#!/bin/bash

CONFIGURE_VIM=${CONFIGURE_VIM:-true}
VIM_CONFIG="${VIM_CONFIG:-coc}"
SOURCE_DIR=${SOURCE_DIR:-'/tmp/dotfiles'}
YCM_FLAGS=${YCM_FLAGS:-'--clang-completer'}
# Choose version or export NVIM_VERSION=nightly
NVIM_VERSION=${NVIM_VERSION:-'v0.7.0'}
SETUP_NVIM="${SETUP_NVIM:-true}"
USER_NODEJS="${USER_NODEJS:-true}"

OS_VERSION=$(awk '{print $4}' /etc/centos-release | cut -f1 -d'.')
if [ -z "${OS_VERSION}" ]; then
    OS_VERSION="None"
fi

# NOTE: if you want to use 'coc' vim setup, you need to install neovim.
if [ "${SETUP_NVIM}" = "true" ]; then
    curl -L "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim.appimage" -o /tmp/nvim.appimage
    cd /tmp ; chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract && cd -
    mkdir -p "$HOME/.local"
    if [ -d "$HOME/.local/nvim" ]; then
        mv "$HOME/.local/nvim" "/tmp/nvim-old"
    fi
    mv /tmp/squashfs-root "$HOME/.local/nvim"
    NVIM_PATH="$HOME/.local/nvim/usr/bin/nvim"

    if ! grep -q 'alias vim' "${HOME}/.zshrc" && echo "$SHELL" | grep -q 'zsh'; then
        echo "alias vim=\"$NVIM_PATH\"" >> "${HOME}/.zshrc"
        echo "alias vimdiff=\"$NVIM_PATH -d\"" >> "${HOME}/.zshrc"
        echo "export PATH=${HOME}/.local/bin:/usr/local/bin/:\$PATH" >> "${HOME}/.zshrc"
        source "$HOME/.zshrc"
    elif ! grep -q 'alias vim' "${HOME}/.bashrc" && echo "$SHELL" | grep -q 'bash'; then
        echo "alias vim=\"$NVIM_PATH\"" >> "${HOME}/.bashrc"
        echo "alias vimdiff=\"$NVIM_PATH -d\"" >> "${HOME}/.bashrc"
        echo "export PATH=${HOME}/.local/bin:/usr/local/bin/:\$PATH" >> "${HOME}/.bashrc"
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
    if [ -d "${SOURCE_DIR}" ]; then
        mv "${SOURCE_DIR}" "${SOURCE_DIR}-$(date '+%d-%m-%Y')"
    fi
    git clone https://github.com/danpawlik/dotfiles.git "${SOURCE_DIR}"

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

    if [ "${VIM_CONFIG}" == 'coc' ]; then
        if ! command -v npm ; then
            echo "Setup NodeJS"
            if [ "${USER_NODEJS}" = "true" ]; then
                if [ -f "${HOME}/.local/nodejs/bin/npm" ]; then
                    export PATH=${HOME}/.local/bin:/usr/local/bin/:$PATH
                else
                    sudo yum install -y xz
                    mkdir -p "${HOME}/.local"
                    curl -LO https://nodejs.org/dist/v17.1.0/node-v17.1.0-linux-x64.tar.xz
                    curl -LO https://yarnpkg.com/latest.tar.gz
                    tar xaf node-v17.1.0-linux-x64.tar.xz ; \
                        mv node-v17.1.0-linux-x64 "${HOME}/.local/nodejs" ; \
                        rm node-v17.1.0-linux-x64.tar.xz ; \
                        mkdir -p "${HOME}/.local/bin"; \
                        ln -s "${HOME}/.local/nodejs/bin/npm" "${HOME}/.local/bin/npm" ; \
                        ln -s "${HOME}/.local/nodejs/bin/node" "${HOME}/.local/bin/node" ; \
                        mkdir -p "${HOME}/.local/yarn" ; \
                        tar xaf latest.tar.gz  -C "${HOME}/.local/yarn" --strip-components 1 ; \
                        rm latest.tar.gz ; \
                        ln -s "${HOME}/.local/yarn/bin/yarn" "${HOME}/.local/bin/yarn"
                    cd -
                    export PATH=${HOME}/.local/bin:/usr/local/bin/:$PATH
                fi
            else
                export LC_ALL=en_US.UTF-8
                # NOTE: it install lts nodejs version without prompt
                # bash <(curl -sL install-node.now.sh/lts ) -f
                curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
                sudo yum install -y nodejs
            fi

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
        $NVIM_PATH -c "" +qall || vim -c "" +qall
        echo "You can also install other modules by running command in the vim: :CocList marketplace"
        pip3 install --user types-PyYAML types-requests pylama
    fi

    # Other packages required by Ale
    pip3 install --user neovim mypy pynvim rstcheck proselint \
                        gitlint ansible-lint black yapf vim-vint yamllint \
                        jedi jedi-language-server pylint mypy
    sudo npm install -g prettier eslint
    sudo yum install -y ShellCheck ocaml-merlin ripgrep fd-find || true
fi
