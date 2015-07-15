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

" remove automaticly whitespaces on the end
autocmd BufWritePre *.py :%s/\s\+$//e

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
let g:syntastic_python_checkers = ['python']
let g:syntastic_quiet_messages = { "type": "style" }


"""" end syntastic

""""" jedi-vim

" let g:jedi#auto_vim_configuration = 1
" let g:jedi#auto_initialization = 1


"""" Turn off help 
" autocmd FileType python setlocal completeopt-=preview

"""" end jedi-vim


"""""  Unwanted highlighting with Syntastic / Jedi-Vim
" highlight SyntasticWarning NONE
" highlight SyntasticError NONE




