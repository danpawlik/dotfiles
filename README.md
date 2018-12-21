# my-python-vim
My dotfiles configurtion.


Configure Vim with deoplete:

Install required packages:

    sudo apt install -y python-pip pyton3-pip
    pip install neovim
    pip3 install neovim


How to install for vim:

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd /tmp ; git clone https://github.com/dduuch/dotfiles.git -b deoplete
    mv dotfiles/vimrc/.vimrc ~/;
    mkdir -p ~/.vim/


How to install for neovim:

    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -O /tmp/nvim.appimage
    cd /tmp ; chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    mv /tmp/squashfs-root ~/.nvim
    ln -s $HOME/.nvim/usr/bin/nvim /usr/bin/nvim
    mkdir -p $HOME/.config/nvim

    git clone https://github.com/dduuch/dotfiles.git -b ycm /tmp/dotfiles
    mv /tmp/dotfiles/vimrc/.vimrc $HOME/.config/nvim/init.vim


Install plugins:

    vim +BundleInstall +qall

or

    nvim +BundleInstall +qall


If all is installed, check health by execuint command in vim/nvim:

    :checkhealth
