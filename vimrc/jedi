"""" At first type this in command line:
"""" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"""" then in command line type this:
"""" vim +BundleInstall +qall
"""" or in vimrc file type:
"""" to install plugins:  :source % | :PluginInstall
"""" to remove plugins:   :source % | :PluginClean
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
" set cursorcolumn
set showcmd
set smartindent
set smartcase
set nowrap
set ttyfast
set rtp+=~/.vim/bundle/Vundle.vim

"""" vundle
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'

" Code helpers
Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'rodjek/vim-puppet'
Plugin 'plasticboy/vim-markdown'
Plugin 'tmhedberg/simpylfold'
Plugin 'w0rp/ale'

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

Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'

call vundle#end()
""""" end vundle

" disable line numbers
autocmd FileType python setlocal nonumber

" disable checking syntax on paste
set pastetoggle=<F2>

" Showing a different background colour in Vim past 80 characters
set colorcolumn=80
" copy the previous indentation on autoindenting
set copyindent
" ignore case in search
set ignorecase
" automatic wrap text > 80 im python f im python filesiles
au BufRead,BufNewFile *py setlocal textwidth=80

let g:solarized_termcolors = 256
colorscheme badwolf

filetype on
filetype plugin on
filetype indent on

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" remove automaticly whitespaces on the end of all files
autocmd BufWritePre * :%s/\s\+$//e
" autocmd BufWritePre *py :%s/\s\+$//e

"remove preview about module to completion
autocmd FileType python setlocal completeopt-=preview

" the nerd tree - ctrl + n  enabled
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <C-n> :NERDTreeToggle<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

filetype plugin indent on

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236


""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

""" syntasic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" comment line under, if you want to check syntax with pep8 or something else
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_puppet_checkers = ['puppetlint']
let g:syntastic_ansible_checkers = ['ansiblelint']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_yaml_checkers = ['yamlling']
let g:syntastic_vim_checkers = ['vimlint']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_docker_checkers = ['dockerfile_lint']

" let g:syntastic_python_checkers = ['python']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_python_pep9_args="--ignore=E501,W801"
let g:syntastic_python_pylint_args="--disable='fixme, line-too-long, logging-not-lazy, bad-whitespace, invalid-name, missing-docstring'"

" jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 1

""" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:ident_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 80

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" ale
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_completion_enabled = 1

"
let g:SimpylFold_docstring_preview = 1
