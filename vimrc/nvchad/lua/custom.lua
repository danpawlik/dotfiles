-- ============================================================
-- MY CONFIG (ported from kickstart init.lua SECTION 11)
-- Everything in one file:
--   M.plugins  — lazy.nvim specs (colorschemes), used by init.lua
--   M.setup()  — options / highlights / autocmds, runs last
-- ============================================================

local M = {}

-- [[ Plugin specs: colorschemes ]]
-- Loaded eagerly (like kickstart's vim.pack.add) so they show up in
-- :colorscheme <Tab> completion.
M.plugins = {
  { 'sjl/badwolf', lazy = false },
  { 'justinsgithub/oh-my-monokai.nvim', lazy = false },
  { 'ray-x/aurora', lazy = false },
  { 'NTBBloodbath/doom-one.nvim', lazy = false },
  { 'ofirgall/ofirkai.nvim', lazy = false },
  { 'rafalbromirski/vim-aurora', lazy = false },
  { 'challenger-deep-theme/vim', name = 'challenger-deep-theme', lazy = false },
  { 'kaicataldo/material.vim', lazy = false },
  { 'rakr/vim-one', lazy = false },
  { 'jacoborus/tender.vim', lazy = false },
  { 'navarasu/onedark.nvim', lazy = false },
  { 'folke/tokyonight.nvim', lazy = false, opts = { style = 'night' } },
  { 'nlknguyen/papercolor-theme', lazy = false },

  -- Indent guides: colored background (vim-indent-guides) instead of
  -- NvChad's indent-blankline `│` characters, which get copied when
  -- selecting text with the mouse in the terminal.
  { 'lukas-reineke/indent-blankline.nvim', enabled = false },
  {
    'preservim/vim-indent-guides',
    lazy = false,
    init = function()
      vim.g.indent_guides_enable_on_vim_startup = 1
      vim.g.indent_guides_auto_colors = 0
    end,
  },
}

function M.setup()
  vim.o.encoding = 'utf-8'
  vim.o.softtabstop = 2
  vim.o.shiftwidth = 4
  vim.o.expandtab = true
  vim.o.smarttab = true
  vim.o.autoindent = true
  vim.o.hlsearch = true
  vim.o.foldenable = false
  vim.o.cursorcolumn = true
  vim.o.smartindent = true
  vim.o.wrap = false
  vim.o.termguicolors = true
  vim.o.autoread = true
  vim.api.nvim_set_option_value('colorcolumn', '80', {})
  vim.o.mouse = ''

  -- Colorscheme (plugins installed via M.plugins above)
  -- tokyonight styles: 'storm' (dark blue), 'night' (darker), 'moon', 'day'
  vim.cmd [[silent! colorscheme ofirkai-darkblue]]

  -- Highlights clear on colorscheme change — re-apply via ColorScheme autocmd
  local function apply_custom_highlights()
    vim.cmd 'highlight ExtraWhitespace ctermbg=red guibg=red'
    vim.cmd 'highlight nonascii guibg=OrangeRed4 ctermbg=1 term=standout'
    vim.cmd 'highlight! link DiffText MatchParen'
    vim.cmd [[
      highlight AnsibleFailed ctermfg=white ctermbg=darkred guifg=white guibg=#5c0000
      highlight AnsibleChanged ctermfg=blue ctermbg=NONE guifg=#4dabf7 guibg=NONE
      highlight AnsibleOK ctermfg=green ctermbg=NONE guifg=#51cf66 guibg=NONE
    ]]
  end

  -- NvChad: a foreign colorscheme wipes base46 UI highlights; restore the
  -- statusline / tabufline so the NvChad chrome stays readable.
  local function restore_nvchad_ui()
    pcall(dofile, vim.g.base46_cache .. 'statusline')
    pcall(dofile, vim.g.base46_cache .. 'tbline')
  end

  apply_custom_highlights()
  restore_nvchad_ui()
  vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Re-apply custom highlights after colorscheme changes',
    callback = function()
      apply_custom_highlights()
      restore_nvchad_ui()
    end,
  })

  -- Alternating colored indent guides (background only, no characters)
  -- Colors tuned for tokyonight storm: Odd matches Normal bg, Even is
  -- tokyonight's bg_highlight shade.
  local function apply_indent_guide_highlights()
    vim.cmd 'highlight IndentGuidesOdd  guibg=#24283b ctermbg=235'
    vim.cmd 'highlight IndentGuidesEven guibg=#292e42 ctermbg=236'
  end
  apply_indent_guide_highlights()
  vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Re-apply indent guide highlights after colorscheme changes',
    callback = apply_indent_guide_highlights,
  })

  vim.cmd [[match ExtraWhitespace /\s\+$/]]
  vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd [[%s/\s\+$//e]]
      vim.api.nvim_win_set_cursor(0, pos)
    end,
  })

  vim.cmd [[autocmd BufReadPost * syntax match nonascii "[^\x00-\x7F]"]]

  -- Simple Ansible log highlighting
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' }, {
    callback = function(args)
      local bufnr = args.buf
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      for i, line in ipairs(lines) do
        if line:match 'FAILED' then
          vim.api.nvim_buf_add_highlight(bufnr, -1, 'AnsibleFailed', i - 1, 0, -1)
        elseif line:match 'changed:' then
          vim.api.nvim_buf_add_highlight(bufnr, -1, 'AnsibleChanged', i - 1, 0, -1)
        elseif line:match 'ok:' then
          vim.api.nvim_buf_add_highlight(bufnr, -1, 'AnsibleOK', i - 1, 0, -1)
        end
      end
    end,
  })

  -- Diff mode colorscheme (badwolf/tokyonight from M.plugins above)
  vim.api.nvim_create_autocmd({ 'OptionSet', 'BufEnter' }, {
    pattern = 'diff',
    callback = function()
      if vim.o.diff then
        vim.cmd 'colorscheme badwolf'
      else
        vim.cmd 'colorscheme tokyonight'
      end
    end,
  })
end

return M
