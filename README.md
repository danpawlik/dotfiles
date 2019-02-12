# my-python-vim
My dotfiles configurtion.

Configure and install neovim:

How to install for neovim and replace vim:

    wget https://github.com/neovim/neovim/releases/download/v0.3.4/nvim.appimage -O /tmp/nvim.appimage
    chmod u+x /tmp/nvim.appimage
    sudo mv /usr/bin/vim /usr/bin/vim-original
    sudo mv /tmp/nvim.appimage /usr/bin/vim


Finally create symlink to neovim:

    mkdir -p $HOME/.config/nvim
    ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim


Vim preparation:

    mkdir -p ~/.vim/
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    git clone https://github.com/dduuch/dotfiles.git /tmp/dotfiles


Take one configuration:

- deoplete:

Install required packages:

    sudo apt install -y python-pip python3-pip || dnf install -y python-pip python3-pip
    pip install --user neovim
    pip3 install --user neovim

Copy deoplete config file:

    mv dotfiles/vimrc/deoplete ~/.vimrc;

If all is installed, check health by execuint command in vim/nvim:

    :checkhealth
- YouCompleteMe (YCM)

    mv /tmp/dotfiles/vimrc/ycm ~/.vimrc

On the end, compile YCM for e.g. python:

    sudo apt install -y build-essential cmake || sudo dnf install -y automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel

    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer


- Jedi vim:

    sudo apt install -y vim-python-jedi || sudo dnf install -y vim-jedi
    mv /tmp/dotfiles/vimrc/jedi ~/.vimrc

- Spacevim

Install using script:
```
curl -sLf https://spacevim.org/install.sh | bash
```

Copy configuration:
```
cp -a /tmp/dotfiles/.SpaceVim.d ~/.SpaceVim.d


Thats all!

Thanks @spacevim team!


Post preparations - install plugins:

    vim +BundleInstall +qall

or

    nvim +BundleInstall +qall
