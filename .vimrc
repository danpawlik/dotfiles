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

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>



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
let g:pymode_doc_bind = 'K'

" remove module doc
autocmd FileType python setlocal completeopt-=preview



"checker
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_message = 1
"let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_lint_checkers = ['pylint']
"ignore W-warnings , and C - critical that begins on C0111
let g:pymode_lint_ignore = "W, C, R"
" let g:pymode_lint_sort = ['E', 'W', 'C']

" completion
let g:pymode_rope=0
let g:pymode_rope_completion = 1
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_autoimport = 0

" syntax
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1

let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all


