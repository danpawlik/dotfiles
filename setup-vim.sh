#!/bin/bash

VIM_CONFIG="${VIM_CONFIG:-ycm}"
SETUP_NEOVIM="${SETUP_NEOVIM:-true}"


mkdir -p ~/.vim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/danpawlik/dotfiles.git /tmp/dotfiles


sudo apt install -y python-pip python3-pip || sudo yum install -y python3-pip
pip3 install --user neovim mypy


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
    sudo mv /tmp/nvim.appimage /usr/bin/nvim
    chmod u+x /usr/bin/nvim
    if [ -f "${HOME}/.zshrc" ]; then
        echo "alias vim=nvim" >> "${HOME}/.zshrc"
#        source $HOME/.zshrc
    elif [ -f "${HOME}/.bashrc" ]; then
        echo "alias vim=nvim" >> "${HOME}/.bashrc"
#        source $HOME/.zshrc
    fi

    mkdir -p "${HOME}/.config/nvim"
    ln -s "${HOME}/.vimrc" "${HOME}/.config/nvim/init.vim"

    curl -fLo "${HOME}/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty
fi
