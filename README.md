# my-python-vim
My dotfiles configurtion.


Configure Vim with deoplete:

Install required packages:

    sudo apt install -y python-pip python3-pip
    pip install --user neovim
    pip3 install --user neovim


How to install for vim:

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd /tmp ; git clone https://github.com/dduuch/dotfiles.git -b deoplete
    mv dotfiles/vimrc/.vimrc ~/;
    mkdir -p ~/.vim/


How to install for neovim and replace vim:

    wget https://github.com/neovim/neovim/releases/download/v0.3.4/nvim.appimage -O /tmp/nvim.appimage
    chmod u+x /tmp/nvim.appimage
    mv /usr/bin/vim /usr/bin/vim-original
    mv /tmp/nvim.appimage /usr/bin/vim

    mkdir -p $HOME/.config/nvim
    ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim


Install plugins:

    vim +BundleInstall +qall

or

    nvim +BundleInstall +qall


If all is installed, check health by execuint command in vim/nvim:

    :checkhealth
