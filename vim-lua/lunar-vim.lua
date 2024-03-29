--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"
lvim.colorscheme = "tokyonight"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "sunjon/Shade.nvim" },
  { "lewis6991/spellsitter.nvim" },
  { "yamatsum/nvim-cursorline" },
  -- show tabs and spaces colors
  --  { "lukas-reineke/indent-blankline.nvim" },
  { "glepnir/indent-guides.nvim" },
  --show signatures
  { "ray-x/lsp_signature.nvim" },
  -- colorscheme
  -- { "folke/tokyonight.nvim"},
  { "cpea2506/one_monokai.nvim" },
  { "navarasu/onedark.nvim" },
  { "nlknguyen/papercolor-theme" },
  -- check how the markdown looks like by typing: :MarkdownPreview
  { "iamcco/markdown-preview.nvim" },
  -- decrypt base64 content
  { "christianrondeau/vim-base64" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

--------------------------------------------------------------------------
-------------------- Custom configuration --------------------------------
--------------------------------------------------------------------------

-- disable visual mouse mark
-- vim.cmd [[set mouse-=a]]
vim.opt.mouse = 'v'

-- remove whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- add color column
-- vim.cmd [[ set colorcolumn=80 ]]
vim.opt.colorcolumn = "80"

-- Show errors near the code
-- note: you can always type: g l or <space> g l
lvim.lsp.diagnostics.virtual_text = true

-- colorscheme setup
require('onedark').setup {
  style = 'darker'
}
require('onedark').load()

--------------------------------------------------------------------------
--------------------- plugin configuration -------------------------------
--------------------------------------------------------------------------

-- setup sigrantures
cfg = {}
require "lsp_signature".setup(cfg)

-- shade
require 'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up   = '<C-Up>',
    brightness_down = '<C-Down>',
    toggle          = '<Leader>s',
  }
})

-- spellsitter
require('spellsitter').setup()

-- cursorline
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}

-- indent - spaces, tabs etc.
require('indent_guides').setup({
  indent_levels = 30;
  indent_guide_size = 1;
  indent_start_level = 1;
  indent_enable = true;
  indent_space_guides = true;
  indent_tab_guides = false;
  indent_soft_pattern = '\\s';
  exclude_filetypes = {
    'help',
    'dashboard',
    'dashpreview',
    'NvimTree',
    'vista',
    'sagahover'
  };
  even_colors = { fg = '#2a3834', bg = '#4a4a61' };
  odd_colors = { fg = '#332b36', bg = '#3b4a46' };
})
