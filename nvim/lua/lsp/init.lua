local u = require("config.utils")
local null_ls = require("lsp.null-ls")
local tsserver = require("lsp.tsserver")
local solargraph = require("lsp.solargraph")
local eslint = require("lsp.eslint")

local lsp = vim.lsp
local api = vim.api

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

local border_opts = { border = "single", focusable = false, scope = "line" }

vim.diagnostic.config({ virtual_text = false, float = border_opts })

local popup_opts = { border = "none", focusable = true }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

_G.global.lsp = {
    border_opts = border_opts,
}

local on_attach = function(client, bufnr)
    -- commands
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspDiagPrev", "vim.diagnostic.goto_prev({ popup_opts = global.lsp.popup_opts })")
    u.lua_command("LspDiagNext", "vim.diagnostic.goto_next({ popup_opts = global.lsp.popup_opts })")
    u.lua_command("LspDiagLine", "vim.diagnostic.show_line_diagnostics(global.lsp.popup_opts)")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

    -- bindings
    u.buf_map(bufnr, "n", "gi", ":LspRename<CR>")
    u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
    u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    u.buf_map(bufnr, "n", ",a", ":LspDiagLine<CR>")
    u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

    -- telescope || fzf-lua
    u.buf_map(bufnr, "n", "gr", ":LspRef<CR>")
    u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    u.buf_map(bufnr, "n", "ga", ":LspAct<CR>")

    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({})
            augroup END
        ]])
    end

    require("illuminate").on_attach(client)
end

tsserver.setup(on_attach)
null_ls.setup(on_attach)
eslint.setup(on_attach)
solargraph.setup(on_attach)
-- require'lspconfig'.graphql.setup{}
