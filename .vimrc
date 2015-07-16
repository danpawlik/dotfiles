"""" to install plugins, you can add into .vimrc and enter:
"""" vim +BundleInstall +qall
"""" in command line or
"""" in .vimrc enter :source % and later  :PluginInstall
"""" to remove :PluginClean

syntax on
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

let g:solarized_termcolors = 256
set t_Co=256
set background=dark
colorscheme solarized

set statusline+=%#warningmsg#
set statusline+=%*
set hlsearch
set nofoldenable
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin indent on



"""" Showing a different background colour in Vim past 80 characters
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(81,999),",")

" remove automaticly whitespaces on the end of all files
autocmd BufWritePre * :%s/\s\+$//e
" autocmd BufWritePre *py :%s/\s\+$//e

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"""" vundle
call vundle#begin()


Plugin 'gmarik/Vundle.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'klen/python-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
call vundle#end()

""""" end vundle


""" the nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""" airline
let g:airline#extensions#tabline#enabled = 1


"""" pymode
let g:pymode_options = 1
let g:pymode_folding = 1


let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" remove module doc
autocmd FileType python setlocal completeopt-=preview



"checker
let g:pymode_lint = 0
let g:pymode_lint_on_write = 1
let g:pymode_lint_message = 1
"let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_lint_checkers = ['pylint']
let g:pymode_lint_ignore = "E501,E302,E261,E262,E701,E241,E126,E127,E128,W801,C0103,C0111,I0011,I0012,W0704,W0142,W0212,W0232,W0613,W0702,R0201,W0614,R0914,R0912,R0915,R0913,R0904,R0801"

" completion
let g:pymode_rope_completion = 1
let g:pymode_rope_lookup_project = 0


" syntax
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1

let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all


