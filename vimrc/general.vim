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
set wildmenu
set cursorline
set cursorcolumn
set showcmd
set smartindent
set smartcase
set nowrap
set ttyfast
set backspace=indent,eol,start
set updatetime=300
set shortmess+=c
set colorcolumn=80
set copyindent
set ignorecase
set signcolumn=yes
set hidden
set termguicolors

let g:go_version_warning = 0

" skip whole words with arrows
execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"

" key mapping
set pastetoggle=<F2>
noremap <F3> :ALEFix<CR>
noremap <F4> :Prettier<CR>
noremap <C-f> :FZF<CR>

filetype off
filetype plugin indent on

silent! colorscheme molokai

" remove automaticly whitespaces on the end of all files / highlight whitechars
autocmd BufWritePre * :%s/\s\+$//e
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

"" disable line numbers
"" replace * with e.g. python to set nonumber for python files
" autocmd FileType * setlocal nonumber
" automatic wrap text > 80 im python f im python filesiles

au BufRead,BufNewFile *py setlocal textwidth=80
"remove preview about module to completion
autocmd FileType python setlocal completeopt-=preview

" Highlight unicode symbols/chars
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
