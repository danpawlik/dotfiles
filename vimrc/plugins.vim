"" To install/update/remove plugins from vimrc-common:
"" :source %
"" then:
"" to install plugins: :PlugInstall
"" to update plugins:  :PlugUpdate
"" to remove plugins:  :PlugClean
"" To update vim coc modules, use command: vim -c 'CocUpdateSync' or ':CocUpdateSync'
"""" plugged
call plug#begin('~/.vim/plugged')

"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"Plug 'Shougo/deoplete.nvim'
"Plug 'davidhalter/jedi-vim'
"Plug 'zxqfl/tabnine-vim', { 'do': './install.py --clang-completer' }
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Helpers
" Automatic closing of brackets/tmux/statusline/fuzyy finder
Plug 'nathanaelkane/vim-indent-guides'
Plug 'raimondi/delimitMate'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'

" Git / shows git diff markers
Plug 'tpope/vim-fugitive'

" syntax/snippets/
Plug 'dense-analysis/ale'
Plug 'sirver/ultisnips'

" languagepack collecion
Plug 'sheerun/vim-polyglot'

" Python
Plug 'python-mode/python-mode'
Plug 'puremourning/vimspector'

" Haskell
Plug 'neovimhaskell/haskell-vim'

" Log
Plug 'MTDL9/vim-log-highlighting'

" Markdown .md / RestructuredTextRuntime .rst
Plug 'plasticboy/vim-markdown'
Plug 'marshallward/vim-restructuredtext'

" Dhall
Plug 'vmchale/dhall-vim'
Plug 'autozimu/LanguageClient-neovim', {
     \ 'branch': 'next',
     \ 'do': 'bash install.sh',
     \ }

" Pretty code
Plug 'prettier/vim-prettier'
Plug 'eslint/eslint'

"colorscheme
Plug 'fatih/molokai'
Plug 'ayu-theme/ayu-vim'
Plug 'challenger-deep-theme/vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf'
Plug 'jacoborus/tender.vim'
Plug 'sainnhe/sonokai'
Plug 'rainglow/vim'
call plug#end()
""""" end plugged
