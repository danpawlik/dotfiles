# my-python-vim
My dotfiles configurtion.

# Vim configuration:

## 1. Preparation:
```
mkdir -p ~/.vim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/danpawlik/dotfiles.git /tmp/dotfiles
```

Install additional packages:
```
sudo apt install -y python-pip python3-pip || sudo yum install -y python3-pip
sudo pip3 install mypy
```

If you want to use neovim:
```
sudo pip3 install neovim
```

## 2. Take one configuration:

### - deoplete:

Copy deoplete config file:
```
cp /tmp/dotfiles/vimrc/deoplete ~/.vimrc;
```
Install plugins:
```
vim +PlugInstall +qall
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
vim +PlugInstall +qall
```
Bellow commands are not required. Plugged will do that for us ;)
```
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```
Thanks @Valloric/YouCompleteMe


### - Jedi vim:
```
sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi
sudo yum install -y python2-setuptools.noarch python3-setuptools.noarch
cp /tmp/dotfiles/vimrc/jedi ~/.vimrc
vim +PlugInstall +qall
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
The best option if you don't have `vim > 8.0` is to
replace vim with neovim.

How to install for neovim and replace vim:

Install FUSE (https://github.com/AppImage/AppImageKit/wiki/FUSE):
```
sudo yum install epel-release -y
sudo yum install fuse-sshfs -y
sudo user="$(whoami)"
sudo usermod -a -G fuse "$user"
```

Download latest nvim appimage:
```
curl -SL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > /tmp/nvim.appimage
sudo mv /tmp/nvim.appimage /usr/bin/nvim
chmod u+x /usr/bin/nvim
if [ -f "$HOME/.zshrc" ]; then
  echo "alias vim=nvim" >> $HOME/.zshrc
elif [ -f "$HOME/.bashrc" ]; then
  echo "alias vim=nvim" >> $HOME/.bashrc
fi
```

Finally create symlink neovim to vim:
```
mkdir -p $HOME/.config/nvim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
```

Install plugged for neovim:
```
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
```
