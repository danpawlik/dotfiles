#!/bin/bash

VIM_CONFIG="${VIM_CONFIG:-ycm}"
SETUP_NEOVIM="${SETUP_NEOVIM:-true}"


mkdir -p ~/.vim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/danpawlik/dotfiles.git /tmp/dotfiles


sudo apt install -y python-pip python3-pip || sudo yum install -y python3-pip
pip3 install --user neovim mypy

OS_VERSION=$(awk '{print $4}' /etc/centos-release | cut -f1 -d'.')

if [ $OS_VERSION -eq 7 ] && [ "${VIM_CONFIG}" == 'ycm' ]; then
    yum install -y devtoolset-8 centos-release-scl
    scl enable devtoolset-8 bash
fi


if [ "${VIM_CONFIG}" == 'ycm' ]; then
    sudo apt install -y build-essential cmake || sudo yum install -y automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel
fi

if [ "${VIM_CONFIG}" == 'jedi' ]; then
    sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi python2-setuptools python3-setuptools
fi

if [ "${VIM_CONFIG}" == 'coc' ]; then
    curl -sL install-node.now.sh/lts | bash
fi

if [ "${VIM_CONFIG}" == 'spacevim' ]; then
    curl -sLf https://spacevim.org/install.sh | bash
    cp -a /tmp/dotfiles/.SpaceVim.d ~/.SpaceVim.d
fi

if [ "${VIM_CONFIG}" != 'spacevim' ]; then
    cp "/tmp/dotfiles/vimrc/${VIM_CONFIG}" ~/.vimrc
fi

vim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty


if [ "${SETUP_NEOVIM}" = 'true' ]; then
    curl -SL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > /tmp/nvim.appimage

    if [ -f "/etc/centos-release" ] && cat /etc/os-release  | grep VERSION_ID | grep -q '7'; then
        sudo mv /tmp/nvim.appimage /usr/local/nvim
        cd /usr/local/ && chmod u+x nvim && ./nvim --appimage-extract
        NVIM_PATH=/usr/local/squashfs-root/usr/bin/nvim
    else
        sudo mv /tmp/nvim.appimage /usr/bin/nvim
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

    mkdir -p "${HOME}/.config/nvim"
    ln -s "${HOME}/.vimrc" "${HOME}/.config/nvim/init.vim"

    curl -fLo "${HOME}/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty
fi
