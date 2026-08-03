-- Alternating colored indent guides (background only, no characters)

vim.pack.add { 'https://github.com/preservim/vim-indent-guides' }
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_auto_colors = 0
vim.cmd [[autocmd VimEnter,Colorscheme * highlight IndentGuidesOdd  guibg=#232526 ctermbg=235]]
vim.cmd [[autocmd VimEnter,Colorscheme * highlight IndentGuidesEven guibg=#293739 ctermbg=236]]
