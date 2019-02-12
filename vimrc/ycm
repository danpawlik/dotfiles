"""" At first type this in command line:
"""" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"""" then in command line type this:
"""" vim +BundleInstall +qall
"""" or in vimrc file type:
"""" to install plugins:  :source % | :PluginInstall
"""" to remove plugins:   :source % | :PluginClean
set encoding=utf-8
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set t_Co=256
set background=dark
set shiftwidth=4
set hlsearch
set nofoldenable
set nocompatible
set encoding=utf-8
set wildmenu
set cursorline

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set hlsearch
set nofoldenable
set nocompatible

" set cursorcolumn
set showcmd
set nowrap
set ttyfast

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

"""" vundle
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'sirver/ultisnips'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'
Plugin 'tpope/vim-surround'

"colorscheme
Plugin 'kiddos/malokai'
Plugin 'morhetz/gruvbox'
Plugin 'ajh17/spacegray.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'henrynewcomer/vim-theme-papaya'
Plugin 'wolf-dog/nighted.vim'
Plugin 'dikiaap/minimalist'
Plugin 'cocopon/iceberg.vim'
Plugin 'sjl/badwolf'
call vundle#end()
""""" end vundle

let g:solarized_termcolors = 256
set t_Co=256
set background=dark
colorscheme badwolf

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



filetype plugin indent on

""" the nerd tree - ctrl + n  enabled
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

""" syntasic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"comment line under, if you want to check syntax with pep8 or something else
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_puppet_checkers = ['puppet', 'puppetlint']
"let g:syntastic_perl_checkers = ['perl']
let g:syntastic_go_checkers = ['go']
"let g:syntastic_cpp_checkers = ['gcc']

" let g:syntastic_python_checkers = ['python']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_python_pep9_args="--ignore=E501,W801"
let g:syntastic_python_pylint_args="--disable='fixme, line-too-long, logging-not-lazy, bad-whitespace, invalid-name, missing-docstring'"

"remove preview about module to completion
autocmd FileType python setlocal completeopt-=preview


"""YouCompleteMe
"option shows help about module to completion
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_auto_trigger = 1


""" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:ident_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 80
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236

" test
" copy the previous indentation on autoindenting
set copyindent
" ignore case in search
set ignorecase
" automatic wrap text > 80 im python f im python filesiles
au BufRead,BufNewFile *py setlocal textwidth=80

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
