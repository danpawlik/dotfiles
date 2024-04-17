--- https://github.com/neovim/nvim-lspconfig/tree/master?tab=readme-ov-file#suggested-configuration
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
     on_attach = on_attach,settings = {
         pyright = {
             autoImportCompletion = true,
         },
         python = {
             analysis = {
                 autoSearchPaths = true,
                 diagnosticMode = 'openFilesOnly',
                 useLibraryCodeForTypes = true,
                 typeCheckingMode = 'basic',
             }
         }
     }
}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}
