" taken from https://github.com/scrapbird/dotfiles/blob/master/config/nvim/init.vim
set nocompatible

" Has to be here so that plugins can use it
let mapleader=" "

source $HOME/.vim/plugins.vim
source $HOME/.vim/plugins_conf.vim
source $HOME/.vim/general.vim

"source $HOME/.vim/plugin_conf/coc
"source $HOME/.vim/plugin_conf/ycm

" NOTE: Dunno why, in new neovim, mouse-=a does not work, so enable visual
" mark, then disable.
set mouse=a
set mouse-=a
set viminfo='100,<1000,s100,h
