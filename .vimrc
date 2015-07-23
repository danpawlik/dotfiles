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


"" disable checking syntax on paste
set pastetoggle=<F2>


"""" Showing a different background colour in Vim past 80 characters
set colorcolumn=80

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
Plugin 'nathanaelkane/vim-indent-guides'
call vundle#end()

""""" end vundle


""" the nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

"syntasic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

"comment line under, if you want to check syntax with pep8 or something else
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_puppet_checkers = ['puppet', 'puppetlint']
"let g:syntastic_perl_checkers = ['perl']
"let g:syntastic_go_checkers = ['go']
"let g:syntastic_cpp_checkers = ['gcc']

" let g:syntastic_python_checkers = ['python']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_python_pep9_args="--ignore=E501,W801"
let g:syntastic_python_pylint_args="--disable='fixme, line-too-long, logging-not-lazy, bad-whitespace, invalid-name, missing-docstring'"

autocmd FileType python setlocal completeopt-=preview


"YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_auto_trigger = 1
let g:ycm_autoclose_preview_window_after_completion = 1


""" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:ident_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 80
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236

