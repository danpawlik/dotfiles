#!/bin/bash

CONFIGURE_VIM=${CONFIGURE_VIM:-true}
VIM_CONFIG="${VIM_CONFIG:-ycm}"
SETUP_NEOVIM="${SETUP_NEOVIM:-true}"
SOURCE_DIR=${SOURCE_DIR:-'/tmp/dotfiles'}

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

    cp -v "${SOURCE_DIR}/vimrc/common" "${HOME}/.vimrc"
    # FIXME: vimplug can not read from multiple paths, so at first install
    # common libraries then specified.
    vim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty


    if [ "${VIM_CONFIG}" == 'ycm' ]; then
        sudo apt install -y build-essential cmake || sudo yum install -y automake gcc gcc-c++ kernel-devel cmake python3-devel
    fi

    if [ $OS_VERSION -eq 7 ] && [ "${VIM_CONFIG}" == 'ycm' ]; then
        yum install -y devtoolset-8 centos-release-scl cmake
    fi

    if [ "${VIM_CONFIG}" == 'jedi' ]; then
        sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi python3-setuptools
    fi

    if [ "${VIM_CONFIG}" == 'coc' ]; then
        export LC_ALL=en_US.UTF-8
        curl -sL install-node.now.sh/lts | bash
        vim +PlugInstall +qall
        for plugin in coc-sh coc-json coc-utils coc-pyright coc-html \
                      coc-yaml coc-prettier coc-snippets coc-python \
                      coc-git coc-go coc-docker; do
            vim +'CocInstall "$plugin"' +qall &> /dev/null < /dev/tty
        done
    fi

    if [ "${VIM_CONFIG}" == 'spacevim' ]; then
        curl -sLf https://spacevim.org/install.sh | bash
        cp -av "${SOURCE_DIR}/.SpaceVim.d" ~/.SpaceVim.d
    fi

    if [ "${VIM_CONFIG}" != 'spacevim' ]; then
        if [ -f ~/.vimrc ]; then
            mv ~/.vimrc ~/.vimrc-common
        fi
        cp -v "${SOURCE_DIR}/vimrc/${VIM_CONFIG}" ~/.vimrc
    fi

    vim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty

    if [ "${VIM_CONFIG}" == 'ycm' ]; then
    scl enable devtoolset-8 - << \EOF
$HOME/.vim/plugged/YouCompleteMe/install.py
EOF
    fi
fi

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
        echo "alias vim=$NVIM_PATH" >> "${HOME}/.zshrc"
        source $HOME/.zshrc
    elif echo $SHELL | grep -q 'bash'; then
        echo "alias vim=$NVIM_PATH" >> "${HOME}/.bashrc"
        source $HOME/.bashrc
    else
        echo "Add: alias vim=$NVIM_PATH into your shell rc file"
    fi

    alias nvim=$NVIM_PATH
    mkdir -p "${HOME}/.config/nvim"
    ln -s "${HOME}/.vimrc" "${HOME}/.config/nvim/init.vim"

    curl -fLo "${HOME}/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty
fi
