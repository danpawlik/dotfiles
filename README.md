# my-python-vim
My dotfiles configurtion.

# Vim configuration:

## 1. Preparation:
```
mkdir -p ~/.vim/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/danpawlik/dotfiles.git /tmp/dotfiles
```

## 2. Take one configuration:

### - deoplete:

Install required packages:
```
sudo apt install -y python-pip python3-pip || sudo yum install -y python-pip python3-pip
pip install --user neovim
pip3 install --user neovim
```
Copy deoplete config file:
```
cp /tmp/dotfiles/vimrc/deoplete ~/.vimrc;
```
Install plugins:
```
vim +PluginInstall +qall
```

> If all is installed, check health by execuint command in vim/nvim:
```
:checkhealth
```
Thanks @Shougo/deoplete.nvim

### - YouCompleteMe (YCM)

```
cp /tmp/dotfiles/vimrc/ycm ~/.vimrc
```

On the end, compile YCM for e.g. python:
```
sudo apt install -y build-essential cmake || sudo yum install -y automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```
Thanks @Valloric/YouCompleteMe


### - Jedi vim:
```
sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi
cp /tmp/dotfiles/vimrc/jedi ~/.vimrc
vim +PluginInstall +qall
```
Thanks @davidhalter/jedi-vim


### - Spacevim

Install using script:
```
curl -sLf https://spacevim.org/install.sh | bash
```

Copy configuration:
```
cp -a /tmp/dotfiles/.SpaceVim.d ~/.SpaceVim.d
```

Thats all!

Thanks @SpaceVim/SpaceVim team!


## 3. Neovim - configure and install:

How to install for neovim and replace vim:
```
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -O /tmp/nvim.appimage
sudo mv /usr/bin/vim /usr/bin/vim-original
sudo mv /tmp/nvim.appimage /usr/bin/vim
sudo ln -s /usr/bin/vim /usr/bin/nvim
chmod u+x /usr/bin/vim
```

Install FUSE (https://github.com/AppImage/AppImageKit/wiki/FUSE):
```
yum --enablerepo=epel -y install fuse-sshfs # install from EPEL
user="$(whoami)"
usermod -a -G fuse "$user"
```

Finally create symlink to neovim:
```
mkdir -p $HOME/.config/nvim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
nvim +BundleInstall +qall

pip3 install neovim && pip2 install neovim
```
