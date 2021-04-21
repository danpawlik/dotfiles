#!/bin/bash

CONFIGURE_VIM=${CONFIGURE_VIM:-true}
VIM_CONFIG="${VIM_CONFIG:-ycm}"
SETUP_NEOVIM="${SETUP_NEOVIM:-true}"
SOURCE_DIR=${SOURCE_DIR:-'/tmp/dotfiles'}
YCM_FLAGS=${YCM_FLAGS:-'--clang-completer'}

# NOTE: if you want to use 'coc' vim setup, you need to install neovim.
#
if [ "${SETUP_NEOVIM}" = "true" ]; then
    curl -SL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > "${SOURCE_DIR}/nvim.appimage"

    if [ -f "/etc/centos-release" ] && cat /etc/os-release  | grep VERSION_ID | grep -q '7'; then
        sudo mv "${SOURCE_DIR}/nvim.appimage" /usr/local/nvim
        cd /usr/local/ && chmod u+x nvim && ./nvim --appimage-extract
        NVIM_PATH=/usr/local/squashfs-root/usr/bin/nvim
    else
        sudo mv "${SOURCE_DIR}/nvim.appimage" /usr/bin/nvim
        chmod u+x /usr/bin/nvim
        NVIM_PATH=/usr/bin/nvim
    fi

    if echo $SHELL | grep -q 'zsh'; then
        echo "alias vim=\"$NVIM_PATH\"" >> "${HOME}/.zshrc"
        echo "alias vimdiff=\"$NVIM_PATH -d\"" >> "${HOME}/.zshrc"
        source $HOME/.zshrc
    elif echo $SHELL | grep -q 'bash'; then
        echo "alias vim=\"$NVIM_PATH\"" >> "${HOME}/.bashrc"
        echo "alias vimdiff=\"$NVIM_PATH -d\"" >> "${HOME}/.bashrc"
        source $HOME/.bashrc
    else
        echo "Add: alias vim=$NVIM_PATH into your shell rc file"
    fi

    alias nvim=$NVIM_PATH
    alias vim=nvim
    mkdir -p "${HOME}/.config/nvim"
    ln -s "${HOME}/.vimrc" "${HOME}/.config/nvim/init.vim"

    curl -fLo "${HOME}/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +'PlugInstall --sync' +PlugInstall +qall &> /dev/null < /dev/tty
fi

if [ "$CONFIGURE_VIM" = "true" ]; then
    mkdir -p ~/.vim/
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    if ! [ -d "${SOURCE_DIR}" ]; then
        git clone https://github.com/danpawlik/dotfiles.git "${SOURCE_DIR}"
    fi

    sudo apt install -y python-pip python3-pip || sudo yum install -y python3-pip
    pip3 install --user neovim mypy pynvim

    OS_VERSION=$(awk '{print $4}' /etc/centos-release | cut -f1 -d'.')

    if [ "${VIM_CONFIG}" == 'ycm' ]; then
        sudo apt install -y build-essential cmake || sudo yum install -y automake gcc gcc-c++ kernel-devel cmake make python3-devel
        if [ "${YCM_FLAGS}" == '--all' ]; then
            # NOTE: drop support for Debian/Ubuntu
			sudo yum install -y golang
            curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
            sudo yum install -y nodejs
        fi
    fi

    if [ $OS_VERSION -eq 7 ] && [ "${VIM_CONFIG}" == 'ycm' ]; then
        yum install -y devtoolset-8 centos-release-scl cmake
    fi

    if [ "${VIM_CONFIG}" == 'coc' ]; then
        echo "Setup NodeJS"
        export LC_ALL=en_US.UTF-8
        # NOTE: it install lts nodejs version without prompt
        # bash <(curl -sL install-node.now.sh/lts ) -f
        curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
        sudo yum install -y nodejs
    fi

    if [ "${VIM_CONFIG}" == 'jedi' ]; then
        sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi python3-setuptools
    fi

    if [ "${VIM_CONFIG}" == 'spacevim' ]; then
        curl -sLf https://spacevim.org/install.sh | bash
        cp -avf "${SOURCE_DIR}/.SpaceVim.d" ~/.SpaceVim.d
    fi

    if [ "${VIM_CONFIG}" != 'spacevim' ]; then
        echo "Copy main vimrc file"
        cp -vf "${SOURCE_DIR}/vimrc/${VIM_CONFIG}" ~/.vimrc
    fi

    echo "Intalling plugings from common file"
    cp -vf "${SOURCE_DIR}/vimrc/common" "${HOME}/.vimrc-common"
    vim -E -s -u ~/.vimrc-common +PlugInstall +qall &> /dev/null

    echo "Installing plugins from vimrc file"
    vim -E -s -u ~/.vimrc +PlugInstall +qall &> /dev/null

    if [ "${VIM_CONFIG}" == 'ycm' ]; then
        echo "Compiling YCM"
        if [ $OS_VERSION -eq 7 ]; then
            scl enable devtoolset-8 - << \EOF
$HOME/.vim/plugged/YouCompleteMe/install.py ${YCM_FLAGS}
EOF
        else
            $HOME/.vim/plugged/YouCompleteMe/install.py
        fi
    fi

    if [ "${VIM_CONFIG}" == 'coc' ]; then
        echo "Setup COC plugins"
        vim -c 'CocInstall -sync coc-snippets coc-fzf coc-sh coc-json coc-utils coc-pyright coc-html coc-yaml coc-prettier coc-python coc-git coc-go coc-docker|q'
        # For web development
        #vim -c 'CocInstall -sync coc-react-refactor coc-reason coc-snippets coc-highlight coc-prettier coc-html-css-support coc-react-refactor coc-reason coc-rescript|q'
        echo "You can also install other modules by installing: :CocInstall coc-marketplace and choose your own with: :CocList marketplace"
    fi
fi
