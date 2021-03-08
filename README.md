# my-python-vim
My dotfiles configurtion.

# Vim configuration:

tl; dr
```
curl -SL https://raw.githubusercontent.com/danpawlik/dotfiles/master/setup-vim.sh | bash
```

## 1. Preparation:
```
mkdir -p ~/.vim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/danpawlik/dotfiles.git /tmp/dotfiles
```

Install additional packages:
```
sudo apt install -y python-pip python3-pip || sudo yum install -y python-pip python3-pip
pip install --user mypy
pip3 install --user mypy
```

If you want to use neovim:
```
pip install --user neovim
pip3 install --user neovim
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
sudo apt install -y vim-python-jedi || sudo yum install -y vim-jedi python2-setuptools python3-setuptools
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

### - CoC vim:
```
curl -sL install-node.now.sh/lts | bash
cp /tmp/dotfiles/vimrc/coc ~/.vimrc
export LC_ALL=en_US.UTF-8
vim +PlugInstall +qall
for plugin in coc-sh coc-json coc-utils coc-pyright coc-html coc-yaml coc-prettier coc-snippets coc-python coc-git coc-go coc-docker; do
vim +'CocInstall "$plugin"' +qall
done
```
Thanks @neoclide/coc.nvim

### - Tabnine vim:
```
cp /tmp/dotfiles/vimrc/tabnine ~/.vimrc
vim +PlugInstall +qall
```
Thanks @codota/TabNine


## 3. Neovim - configure and install:
The best option if you don't have `vim > 8.0` is to
replace vim with neovim.

How to install for neovim and replace vim:

1. Download latest nvim appimage:
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

2. Create symlink neovim to vim:
```
mkdir -p $HOME/.config/nvim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
```

3. Install plugged for neovim:
```
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
```

# ZSH and others

tl; dr
```
curl -LO https://raw.githubusercontent.com/danpawlik/dotfiles/master/install.sh | bash
```
