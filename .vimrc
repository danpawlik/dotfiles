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
set statusline+=%{SyntasticStatuslineFlag()}
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
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'

call vundle#end()

""""" end vundle


""" the nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""" airline
let g:airline#extensions#tabline#enabled = 1


" remove module doc
autocmd FileType python setlocal completeopt-=preview


" youcompleteme

let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:Show_diagnostics_ui = 1 "default 1


let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0


let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_confirm_extra_conf = 1

"syntasic

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"comment line under, if you want to check syntax with pep8 or something else
let g:syntastic_python_checkers = ['python']

let g:syntastic_quiet_messages = { "type": "style" }
"let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pep8_args="--ignore=E501,W801"
let g:syntastic_python_pylint_args="--disable=C, W, R "

autocmd FileType python setlocal completeopt-=preview


"""" end syntastic

