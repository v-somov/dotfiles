local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
    b.formatting.eslint_d,
    b.formatting.trim_whitespace.with({ filetypes = { "tmux", "zsh" } }),
    b.formatting.shfmt,
    b.diagnostics.write_good,
    b.diagnostics.markdownlint,
    b.diagnostics.shellcheck,
}

local M = {}
M.setup = function(on_attach)
    null_ls.config({
        -- debug = true,
        sources = sources,
    })
    require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
