-- local u = require("utils")
-- local commands = require("commands")

-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local previewers = require("telescope.previewers")
-- local action_state = require("telescope.actions.state")
-- local conf = require("telescope.config").values
-- local actions = require("telescope.actions")

-- require("telescope").setup({
    -- defaults = {
        -- file_sorter = require("telescope.sorters").get_fzy_sorter,
        -- prompt_prefix = " >",
        -- color_devicons = true,

        -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        -- mappings = {
            -- i = {
                -- ["<C-x>"] = false,
                -- ["<C-q>"] = actions.send_to_qflist,
            -- },
        -- },
    -- },
    -- extensions = {
        -- fzy_native = {
            -- override_generic_sorter = false,
            -- override_file_sorter = true,
        -- },
    -- },
-- })

-- require("telescope").load_extension("fzy_native")


-- telescope.setup({
    -- extensions = {
        -- fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
    -- },
    -- defaults = {
        -- vimgrep_arguments = {
            -- "rg",
            -- "--color=never",
            -- "--no-heading",
            -- "--with-filename",
            -- "--line-number",
            -- "--column",
            -- "--smart-case",
            -- "--ignore",
            -- "--hidden",
            -- "-g",
            -- "!.git",
        -- },
        -- mappings = {
            -- i = { ["<Esc>"] = require("telescope.actions").close, ["<C-u>"] = false },
        -- },
    -- },
-- })

-- telescope.load_extension("fzf")

-- _G.global.telescope = {
    -- -- try git_files and fall back to find_files
    -- find_files = function()
        -- local set = require("telescope.actions.set")
        -- local builtin = require("telescope.builtin")

        -- local current = vim.api.nvim_get_current_buf()
        -- local opts = {
            -- attach_mappings = function(_, map)
                -- map("i", "<C-v>", function(prompt_bufnr)
                    -- set.edit(prompt_bufnr, "Vsplit")
                -- end)

                -- -- replace current buffer
                -- map("i", "<C-r>", function(prompt_bufnr)
                    -- set.edit(prompt_bufnr, "edit")
                    -- commands.bdelete(current)
                -- end)

                -- -- close all other buffers
                -- map("i", "<C-x>", function(prompt_bufnr)
                    -- set.edit(prompt_bufnr, "edit")
                    -- commands.bonly()
                -- end)

                -- -- edit file and matching test file in split
                -- map("i", "<C-f>", function(prompt_bufnr)
                    -- set.edit(prompt_bufnr, "edit")
                    -- commands.edit_test_file("Vsplit", function()
                        -- vim.cmd("wincmd w")
                    -- end)
                -- end)

                -- return true
            -- end,
        -- }

        -- local is_git_project = pcall(builtin.git_files, opts)
        -- if not is_git_project then
            -- builtin.find_files(opts)
        -- end
    -- end,
-- }

-- u.command("Files", "Telescope git_files")
-- u.lua_command("Rg", "require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})")
-- u.command("BLines", "Telescope current_buffer_fuzzy_find")
-- u.command("History", "Telescope oldfiles")
-- u.command("Buffers", "Telescope buffers")
-- u.command("BCommits", "Telescope git_bcommits")
-- u.command("Commits", "Telescope git_commits")
-- u.command("HelpTags", "Telescope help_tags")
-- u.command("ManPages", "Telescope man_pages")

-- u.map("n", "<Leader>H", ":HelpTags<CR>")

-- u.map("n", "<C-p>", "<cmd>Files<CR>")
-- u.map("n", "<Leader>f", "<cmd>Rg<CR>")
-- u.map("n", "<Leader>b", "<cmd>Buffers<CR>")
-- u.map("n", "<Leader>fh", "<cmd>History<CR>")
-- u.map("n", "<Leader>fl", "<cmd>BLines<CR>")
-- u.map("n", "<Leader>fs", "<cmd>LspSym<CR>")

-- -- lsp
-- u.command("LspRef", "Telescope lsp_references")
-- u.command("LspDef", "Telescope lsp_definitions")
-- u.command("LspSym", "Telescope lsp_workspace_symbols")
-- u.command("LspAct", "Telescope lsp_code_actions")
