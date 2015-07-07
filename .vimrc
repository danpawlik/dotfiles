syntax on
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized


filetype off
execute pathogen#infect()
" execute pathogen#helptags()

filetype plugin indent on

set nofoldenable

" remove automaticly whitespaces on the end
" autocmd BufWritePre *.py :%s/\s\+$//e


" show whitespaces and highlight it
" highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/

