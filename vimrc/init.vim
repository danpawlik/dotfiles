" taken from https://github.com/scrapbird/dotfiles/blob/master/config/nvim/init.vim
set nocompatible

" Has to be here so that plugins can use it
let mapleader=" "

source $HOME/.vim/plugins.vim
source $HOME/.vim/plugins_conf.vim
source $HOME/.vim/general.vim

source $HOME/.vim/plugin_conf/coc
source $HOME/.vim/lua/init.lua

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" More info here: https://github.com/joshdick/onedark.vim#installation
if (empty($TMUX))
  if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has('termguicolors'))
    set termguicolors
  endif
endif

silent! colorscheme PaperColor
" silent! colorscheme material
" silent! colorscheme tender
" silent! colorscheme molokai

" NOTE: Dunno why, in new neovim, mouse-=a does not work, so enable visual
" mark, then disable.
set mouse=a
set mouse-=a
set viminfo='100,<1000,s100,h
