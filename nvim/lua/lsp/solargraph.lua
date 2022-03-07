local lspconfig = require('lspconfig')

local M = {}
M.setup = function(on_attach)
  lspconfig.solargraph.setup({
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
      end,
      flags = {
          debounce_text_changes = 150,
      },
  })
end

return M
