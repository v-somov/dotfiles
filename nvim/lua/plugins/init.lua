local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Core plugin manager itself
	{ "folke/lazy.nvim" },

	-- Utility plugins
	"vim-scripts/copypath.vim",
	"hashivim/vim-terraform",
	"tpope/vim-eunuch",
	"tpope/vim-surround",
	"tpope/vim-sleuth",
	"tpope/vim-unimpaired",
	{
		"tpope/vim-fugitive",
		config = function()
			local u = require("config.utils")
			u.augroup("VimFugitive", "BufReadPost", "fugitive://* ", "set bufhidden=delete")
		end,
	},

	"google/vim-searchindex",
	"yggdroot/indentline",
	"christoomey/vim-tmux-navigator",
	"jszakmeister/vim-togglecursor",
	"godlygeek/tabular",

	{
		"scrooloose/nerdcommenter",
		init = function()
			vim.g.NERDSpaceDelims = 1
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
	},
	{ "lifepillar/vim-solarized8", branch = "neovim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"rebelot/kanagawa.nvim",
	"morhetz/gruvbox",

	{
		"tamago324/lir.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"vijaymarupudi/nvim-fzf",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.fzf")
		end,
	},

	{
		"RRethy/vim-illuminate",
		lazy = false,
		keys = {
			{
				"<A-n>",
				'<cmd>lua require"illuminate".next_reference{wrap=true}<CR>',
				desc = "Next reference",
			},
			{
				"<A-p>",
				'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>',
				desc = "Previous reference",
			},
		},
	},

	{
		"tpope/vim-projectionist",
		config = function()
			require("plugins.projectionist")
		end,
	},
	"theprimeagen/harpoon",
	"theprimeagen/refactoring.nvim",
	"mbbill/undotree",
	"towolf/vim-helm",
	"windwp/nvim-ts-autotag",

	"RRethy/nvim-treesitter-endwise",
	-- Treesitter plugins
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		opts_extend = { "ensure_installed" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"css",
				"ruby",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"embedded_template",
				"go",
			},
			endwise = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	"RRethy/nvim-treesitter-endwise",
	{ "RRethy/nvim-treesitter-textsubjects", ft = { "lua", "typescript", "typescriptreact", "ruby", "eruby" } },
	{ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } },

	-- LSP plugins
	"nvim-lua/plenary.nvim",
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",

			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		opts = {},
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = false,
				ensure_installed = {
					"ts_ls",
					"gopls",
					"lua_ls",
					"ruby_lsp",
					"jsonls",
					"yamlls",
					"html",
					"cssls",
					"bashls",
					"dockerls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							on_attach = function(_, bufnr)
								-- Enable LSP keybindings
								local opts = { noremap = true, silent = true, buffer = bufnr }
								vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
								vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
								vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
								vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
								vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
								vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
							end,
						})
					end,
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettierd",
					"prettier",
					"stylua",
					"gofumpt",
					"goimports",
					"isort",
				},
				run_on_start = true,
			})
		end,
	},

	{ "github/copilot.vim" },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"github/copilot.vim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.copilot")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opt = {},
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"Vigemus/iron.nvim",
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("plugins.conform")
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("plugins.mini")
		end,
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
		config = function()
			require("plugins.noice")
		end,
	},
	{
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/vladsomov/Library/Mobile Documents/com~apple~CloudDocs/personal-vault/personal",
      },
      {
        name = "work",
        path = "/Users/vladsomov/Library/Mobile Documents/com~apple~CloudDocs/personal-vault/work",
      },
    },

    -- see below for full list of options 👇
  },
},
})

require("plugins.theme-switcher")
