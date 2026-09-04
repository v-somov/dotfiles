local utils = require("config.utils")

-- Copilot chat
local chat = require("CopilotChat")
local select = require("CopilotChat.select")

chat.setup({
	model = "gpt-4.1",
	selection = function(source)
		return select.visual(source) or select.buffer(source)
	end,
	prompts = {
		Explain = {
			mapping = "<leader>ae",
			description = "AI Explain",
		},
		Review = {
			mapping = "<leader>ar",
			description = "AI Review",
		},
		Tests = {
			mapping = "<leader>at",
			description = "AI Tests",
		},
		Fix = {
			mapping = "<leader>af",
			description = "AI Fix",
		},
		Optimize = {
			mapping = "<leader>ao",
			description = "AI Optimize",
		},
		Docs = {
			mapping = "<leader>ad",
			description = "AI Documentation",
		},
		Commit = {
			mapping = "<leader>ac",
			description = "AI Generate Commit",
		},
	},
	mappings = {
		complete = {
			insert = "<C-l>",
		},
		close = {
			normal = "q",
			insert = "<C-c>",
		},
		reset = {
			normal = "<C-k>",
			insert = "<C-k>",
		},
		submit_prompt = {
			normal = "<CR>",
			insert = "<C-s>",
		},
		toggle_sticky = {
			detail = "Makes line under cursor sticky or deletes sticky line.",
			normal = "gr",
		},
		accept_diff = {
			normal = "<C-y>",
			insert = "<C-y>",
		},
		jump_to_diff = {
			normal = "gj",
		},
		quickfix_diffs = {
			normal = "gq",
		},
		yank_diff = {
			normal = "gy",
			register = '"',
		},
		show_diff = {
			normal = "<leader>gd",
		},
		show_info = {
			normal = "<leader>gi",
		},
		show_context = {
			normal = "gc",
		},
		show_help = {
			normal = "gh",
		},
	},
})

utils.au("BufEnter", {
	pattern = "copilot-*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})

vim.keymap.set({ "n" }, "<leader>aa", chat.toggle, { desc = "AI Toggle" })
vim.keymap.set({ "v" }, "<leader>aa", chat.open, { desc = "AI Open" })
vim.keymap.set({ "n" }, "<leader>ax", chat.reset, { desc = "AI Reset" })
vim.keymap.set({ "n" }, "<leader>as", chat.stop, { desc = "AI Stop" })
vim.keymap.set({ "n" }, "<leader>am", chat.select_model, { desc = "AI Model" })
vim.keymap.set({ "n", "v" }, "<leader>ap", function()
	chat.select_prompt({
		fzf_tmux_opts = {
			["-d"] = "45%",
		},
	})
end, { desc = "AI Prompts" })
vim.keymap.set({ "n", "v" }, "<leader>aq", function()
	vim.ui.input({
		prompt = "AI Question> ",
	}, function(input)
		if input and input ~= "" then
			chat.ask(input)
		end
	end)
end, { desc = "AI Question" })

vim.keymap.set({ "n", "v" }, "<leader>ccq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, {
			selection = require("CopilotChat.select").buffer,
		})
	end
end)

vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
	desc = "Accept Copilot suggestion",
})
