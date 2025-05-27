local cmp = require("cmp")
local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
	-- Enable LSP keybindings
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ruby_lsp.setup({
	cmd = { "/Users/vladsomov/.asdf/shims/ruby-lsp" },
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.ts_ls.setup({
	settings = {
		typescript = {
			preferences = {
				importModuleSpecifier = "shortest",
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "W391", "W503" },
					maxLineLength = 88,
				},
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.postgres_lsp.setup({
	cmd = { "postgrestools", "lsp-proxy" },
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		bashIde = {
			diagnostic = {
				enable = true,
			},
			completion = {
				enable = true,
			},
		},
	},
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		docker = {
			diagnostic = {
				enable = true,
			},
		},
	},
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	on_attach = on_attach,
})

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
		-- ["<C-Space>"] = cmp.mapping.complete(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		-- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
		["<S-Tab>"] = nil,
	}),
	sources = cmp.config.sources({
		{ name = "copilot" },
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "path" },
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
