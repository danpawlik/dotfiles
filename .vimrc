syntax on
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

let g:solarized_termcolors = 256
set t_Co=256
set background=dark
colorscheme solarized

""" set text width 79
" set textwidth=79
" set formatoptions+=t


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set hlsearch

"""" Showing a different background colour in Vim past 80 characters
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(81,999),",")

" remove automaticly whitespaces on the end of all files
" autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre *py :%s/\s\+$//e

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"""" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'gmarik/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rodjek/vim-puppet'

Plugin 'tomasr/molokai'


call vundle#end()
filetype plugin indent on

""""" end vundle

"""" to install plugins, you can add into .vimrc and enter:
"""" vim +BundleInstall +qall
"""" in command line or
"""" in .vimrc enter :source % and later  :PluginInstall


"""""syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" comment line under, if you want to check syntax with pep8 or something else
" let g:syntastic_python_checkers = ['python']

let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pep8_args="--ignore=E501,E302,E261,E262,E701,E241,E126,E127,E128,W801"
let g:syntastic_python_pylint_args="--disable=C0103,C0111,I0011,I0012,W0704,W0142,W0212,W0232,W0613,W0702,R0201,W0614,R0914,R0912,R0915,R0913,R0904,R0801"

"""" end syntastic

""""" jedi-vim

let g:jedi#auto_vim_configuration = 1
let g:jedi#auto_initialization = 1
autocmd CompleteDone * pclose

"""" Turn off help
autocmd FileType python setlocal completeopt-=preview

"""" end jedi-vim


"""""  Unwanted highlighting with Syntastic / Jedi-Vim
" highlight SyntasticWarning NONE
" highlight SyntasticError NONE




