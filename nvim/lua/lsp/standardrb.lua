local lspconfig = require('lspconfig')

local M = {}
M.setup = function(on_attach)
  lspconfig.standardrb.setup({
      cmd = { "bundle", "exec", "standardrb", "--lsp" },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
      end,
      flags = {
          debounce_text_changes = 150,
      },
  })
end

return M
