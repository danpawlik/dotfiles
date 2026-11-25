local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    python = { "ruff_format" },
    sh = { "shfmt" },
    yaml = { "prettier" },
    json = { "prettier" },
  },

  format_on_save = function(bufnr)
    -- disable autoformat for these filetypes (format manually with <leader>fm)
    local disable_filetypes = { c = true, cpp = true, python = true, lua = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

return options
