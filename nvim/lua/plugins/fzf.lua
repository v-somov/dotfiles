local actions = require("fzf-lua.actions")
local u = require("config.utils")

require("fzf-lua").setup({
	winopts = {
		height = 0.85, -- 85% of Neovim window height
		width = 0.80, -- 80% of Neovim window width
		row = 0.50, -- 50% down from top
		col = 0.50, -- 50% from left
		border = "rounded", -- nice rounded corners
		fullscreen = false,
		preview = {
			default = "bat", -- use bat for previews
			border = "rounded",
			wrap = "nowrap",
			layout = "horizontal", -- right side preview
			horizontal = "right:55%", -- 55% of window to the right
		},
		-- Optional: Uncomment below for some transparency
		winblend = 80,
	},
	hls = {
		normal = "Normal",
		border = "FloatBorder",
		title = "FloatTitle",
		preview = "Normal",
		cursor = "Cursor",
		cursorline = "CursorLine",
		search = "Search",
	},

	fzf_opts = {
		["--ansi"] = "",
		["--prompt"] = " ", -- nerd font arrow
		["--pointer"] = "", -- nerd font pointer
		["--marker"] = "✓",
		["--layout"] = "reverse",
		["--info"] = "inline-right",
		["--scrollbar"] = "▌",
	},

	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
			["<C-e>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-j"] = "down",
			["ctrl-k"] = "up",
			["ctrl-q"] = "select-all+accept",
			["ctrl-t"] = actions.file_tabedit,
			["ctrl-u"] = "clear-query",
			["ctrl-a"] = "beginning-of-line",
			["shift-down"] = "preview-page-down",
			["shift-up"] = "preview-page-up",
			["ctrl-d"] = "half-page-down",
			["ctrl-b"] = "half-page-up",
			["ctrl-w"] = "toggle-preview",
		},
	},

	files = {
		prompt = "Files> ",
		multiprocess = true,
		git_icons = true,
		file_icons = true,
		color_icons = true,
		previewer = "bat",
		-- cmd = "fd --type f --color never --hidden",
		actions = {
			-- Toggle to git files with <C-g>
			["ctrl-g"] = function()
				require("fzf-lua").git_files({
					actions = {
						-- And toggle back to all files with <C-f>
						["ctrl-g"] = function()
							require("fzf-lua").files()
						end,
					},
					fzf_opts = { ["--header"] = "Press <C-g> for all files" },
				})
			end,
			["ctrl-i"] = function()
				require("fzf-lua").files({
					fd_opts = "--color=never --type f --hidden --no-ignore",
					fzf_opts = { ["--header"] = "Showing ALL files (ignoring .gitignore). Press <C-i> to go back." },
					actions = {
						["ctrl-i"] = function()
							-- Go back to respecting .gitignore
							require("fzf-lua").files()
						end,
					},
				})
			end,
		},
		fzf_opts = {
			["--header"] = "Press <C-g> for git files\nPress <C-i> to show ALL files (ignore .gitignore)",
		},
	},
	git_files = {
		prompt = "GitFiles> ",
		git_icons = true,
		file_icons = true,
		color_icons = true,
		actions = {
			["ctrl-g"] = function()
				require("fzf-lua").files()
			end,
		},
		fzf_opts = { ["--header"] = "Press <C-g> for all files" },
	},

	grep = {
		prompt = "  ",
		input_prompt = "Grep For❯ ",
		multiprocess = true,
		git_icons = true,
		file_icons = true,
		color_icons = true,
		previewer = "bat",
	},

	buffers = {
		prompt = "Buffers> ",
		file_icons = true,
		color_icons = true,
		sort_lastused = true,
		show_unlisted = true,
	},
	previewer = {
		-- Use 'bat' for file previews
		default = "bat",
		bat = {
			cursorline = false,
		},
	},

	ui_select = {
		require("fzf-lua.defaults").ui_select,
	},
})

-- Register fzf-lua as the UI select interface (for LSP, code actions, etc)
require("fzf-lua").register_ui_select()

u.lua_command("RgContent", 'require("fzf-lua").grep({ search = "", fzf_cli_args = "--nth 2.." })')
u.lua_command(
	"BSymbols",
	"require('fzf-lua').lsp_document_symbols({ ignore_symbols = 'Variable', fzf_cli_args = '--nth 1..' })"
)
u.lua_command("LspRef", 'require("fzf-lua").lsp_references({ jump_to_single_result = true })')
u.lua_command("LspDef", 'require("fzf-lua").lsp_definitions({ jump_to_single_result = true })')
u.lua_command("LspDefSplit", 'require("fzf-lua").lsp_definitions({ sync = true  })')
u.lua_command("LspTypeDef", 'require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })')

-- Keymaps: Fuzzy find everything, mnemonic and which-key friendly!
vim.keymap.set("n", "<C-P>", "<cmd>FzfLua files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>l", "<cmd>FzfLua live_grep_native<CR>", { desc = "Live Grep Native" })
vim.keymap.set("n", ",f", "<cmd>FzfLua live_grep_glob<CR>", { desc = "Live Grep Glob" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua live_grep_resume<CR>", { desc = "Resume Last Grep" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua commands<CR>", { desc = "Commands" })

u.vmap("<Leader>f", "<ESC> :FzfLua grep_visual<CR>", { desc = "FzfLua Grep Visual" })
u.nmap("<Leader>fw", ":FzfLua grep_cword<CR>", { desc = "FzfLua Grep Cword" })
u.nmap("<Leader>ff", ":RgContent<CR>", { desc = "FzfLua RgContent" })
u.nmap("<Leader>ch", ":FzfLua git_branches<CR>", { desc = "FzfLua Git Branches" })
u.nmap("<Leader>co", ":FzfLua git_bcommits<CR>", { desc = "FzfLua Git Buffer Commits" })
u.nmap("<Leader>ca", ":FzfLua lsp_code_actions<CR>", { desc = "FzfLua LSP Code Actions" })
u.nmap("<Leader>gr", ":LspRef<CR>", { desc = "FzfLua LSP References" })
u.nmap("<Leader>ga", ":LspAction<CR>", { desc = "FzfLua LSP Action" })
u.nmap("<Leader>gd", ":LspDefSplit<CR>", { desc = "FzfLua LSP Definitions (Split)" })
u.nmap("<Leader>d", ":BSymbols<CR>", { desc = "FzfLua Buffer Symbols" })

-- Optional: Set BAT_THEME for light/dark automatic switch (only if you want BAT previews to auto-switch themes)
