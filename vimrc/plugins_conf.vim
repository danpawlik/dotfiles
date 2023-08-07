""" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:ident_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 80

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" ale
let b:ale_linters = {
                  \  'javascript': ['eslint', 'prettier'],
                  \  'typescript': ['eslint', 'tslint'],
                  \  'graphql': ['eslint', 'prettier'],
                  \  'ocaml': ['merlin'],
                  \  'css': ['prettier'],
                  \  'python': ['mypy', 'pycodestyle'],
                  \  'ansible': ['ansible-lint'],
                  \  'yaml': ['prettier', 'yamllint'],
                  \  'json': ['prettier', 'jsonlint'],
                  \  'vim': ['vint'],
                  \  'shell': ['shellcheck'],
                  \  'sh': ['shellcheck'],
                  \  'dockerfile': ['dockerfile_lint'],
                  \  'pod': ['proselint'],
                  \  'make': ['checkmake'],
                  \  'gitcommit': ['gitlint'],
                  \  'haskell': ['ghc', 'hls'],
                  \  'reason': ['merlin'],
                  \  'markdown': ['markdownlint'],
                  \  'rst': ['rstcheck'],
                  \  'go': ['gofmt'],
                  \  'rust': ['cargo']}

let b:ale_fixers = {
                  \  '*': ['remove_trailing_lines', 'trim_whitespace'],
                  \  'python': ['black', 'yapf'],
                  \  'javascript': ['prettier'],
                  \  'typescript': ['prettier'],
                  \  'html': ['prettier'],
                  \  'go': ['gofmt'],
                  \  'json': ['prettier'],
                  \  'jsx': ['prettier'],
                  \  'css': ['prettier'],
                  \  'graphql': ['prettier'],
                  \  'markdown': ['prettier'],
                  \  'yaml': ['prettier']}

let g:ale_list_window_size = 3
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fix_on_save = 0
let g:ale_set_highlights = 1
let g:ale_linters_explicit = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma none --semi false'

"" Python
"let g:pymode_lint = 0

"" Dhall
let g:LanguageClient_serverCommands = {
    \ 'dhall': ['dhall-lsp-server'],
    \ }
let g:dhall_format=1

" autoformatter
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatdef_dhall_format = '"dhall --unicode format"'
autocmd FileType vim,sh,js let b:autoformat_autoindent=0

" prettier
"let g:prettier#autoformat = 1
"let g:prettier#autoformat_require_pragma = 0
"let g:prettier#exec_cmd_async = 1
"let g:prettier#partial_format=1
"let g:prettier#quickfix_enabled = 1
"let g:prettier#config#print_width = '80'
"au FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"

"" Rescript
"autocmd FileType rescript nnoremap <silent> <buffer> <localleader>r :RescriptFormat<CR>
"autocmd FileType rescript nnoremap <silent> <buffer> <localleader>t :RescriptTypeHint<CR>
"autocmd FileType rescript nnoremap <silent> <buffer> <localleader>b :RescriptBuild<CR>
"autocmd FileType rescript nnoremap <silent> <buffer> gd :RescriptJumpToDefinition<CR>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" autocmd VimEnter * NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" show and explain function parameters
inoremap <C-P> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>
