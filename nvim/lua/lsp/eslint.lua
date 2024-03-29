local M = {
    setup = function(on_attach, capabilities)
        local lspconfig = require("lspconfig")

        lspconfig.eslint..setup({
            root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js"),
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                format = {
                    enable = true,
                },
            },
        })
    end,
}

return M
