local actions = require("fzf-lua.actions")

local u = require("config.utils")
local commands = require("config.commands")

-- replace current buffer with selected
local breplace = function(selected)
    commands.bdelete()
    for _, file in ipairs(vim.list_slice(selected, 2)) do
        vim.cmd("e " .. file)
    end
end

-- delete all buffers and open selected
local bonly = function(selected)
    commands.bwipeall()
    for _, file in ipairs(vim.list_slice(selected, 2)) do
        vim.cmd("e " .. file)
    end
end

-- open file and test file in split
local split_test_file = function(selected)
    vim.cmd("e " .. selected[2])
    commands.edit_test_file("Vsplit", function()
        vim.cmd("wincmd w")
    end)
end

-- local vsplit = function(selected)
    -- commands.vsplit(selected[2])
-- end

local trouble_actions = require("trouble.sources.fzf").actions

local file_actions = {
    ["default"] = actions.file_edit_or_qf,
    ["ctrl-t"] = actions.file_tabedit,
    ["ctrl-q"] = actions.file_sel_to_qf,
    ["ctrl-x"] = bonly,
    ["ctrl-r"] = breplace,
    ["ctrl-t"] = trouble_actions.open
    -- ["ctl-v"] = vsplit,
}

require("fzf-lua").setup({
    winopts = {
      -- split = 'belowright new',
      height = 0.8,
      width = 0.9,
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      -- hl_border  = 'NormalFloat',
      preview_horizontal  = 'right:50%:hidden',
    },
    fzf_opts = {
      ['--ansi']        = '',
      ['--prompt']      = ' >',
      ['--info']        = 'inline',
      ['--height']      = '100%',
      ['--layout']      = 'default',
    },
    keymap = {
      fzf = {
        ["ctrl-u"] = "clear-query",
        ["ctrl-a"]      = "beginning-of-line",
        ["shift-down"]    = "preview-page-down",
        ["shift-up"]      = "preview-page-up",
        ["ctrl-d"]        = "half-page-down",
        ["ctrl-b"]        = "half-page-up",
        ["ctrl-w"] = "toggle-preview",
      },
    },
    previewers = {
      bat = {
        cmd             = "bat",
        args            = "--style=changes --color always",
        theme           = 'Solarized (Light)', -- bat preview theme (bat --list-themes)
        config          = nil,            -- nil uses $BAT_CONFIG_PATH
      },
      builtin = {
        -- hidden = true,
        scrollbar = false,
      },
    },
    files = {
      prompt = 'Files> ',
      cmd = 'rg .  --files --no-ignore --hidden --follow -g ".kamal/**" -g "Gemfile*" -g ".gitignore" -g "bin/*" -g "*.{vue,lua,ts,tsx,graphql,coffee,haml,hamlc,erb,js,json,rs,go,rb,py,swift,scss,c,yml,yaml,css,md,php,svg,png,jpg}" -g ".env*" -g "Docker*" -g "Procfile" -g "!{.git,generated,node_modules,dist,vendor,log,swp,tmp,venv,__pychache__,pyc}/*"',
      actions = file_actions,
      git_icons = false,
      color_icons = false,
    },
    grep = {
      -- only search file content, not names
      prompt = 'Files Content> ',
      rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '.kamal/**' -g 'Gemfile*' -g '.gitignore' -g 'bin/*' -g '*.{vue,lua,ts,tsx,graphql,coffee,haml,hamlc,erb,js,rs,go,rb,py,swift,scss,c,md,yml,yaml,php,svg,png,jpg}' -g '.env*' -g 'Docker*' -g 'Procfile' -g '!{.git,**/generated,node_modules,dist,vendor,log,swp,tmp,venv,__pychache__,pyc}/*'",
      actions = file_actions,
    },
    bcommits = {
      previewer = 'bat'
    },
    lsp = {
      -- make lsp requests synchronous so they work with null-ls
      async_or_timeout = 1000,
    },
})

u.lua_command("LspAction", 'require("fzf-lua").lsp_code_actions()')
u.lua_command("LspRef", 'require("fzf-lua").lsp_references({ jump_to_single_result = true })')
u.lua_command("LspDef", 'require("fzf-lua").lsp_definitions({ jump_to_single_result = true })')
u.lua_command("LspDefSplit", 'require("fzf-lua").lsp_definitions({ sync = true  })')
u.lua_command("LspTypeDef", 'require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })')
u.lua_command("Rg", 'require("fzf-lua").grep({ search = "" })')
u.lua_command("RgContent", 'require("fzf-lua").grep({ search = "", fzf_cli_args = "--nth 2.." })')
u.lua_command("BSymbols", "require('fzf-lua').lsp_document_symbols({ ignore_symbols = 'Variable', fzf_cli_args = '--nth 1..' })")

u.command("Files", "FzfLua files")

u.nmap("<C-P>", ":FzfLua files<CR>")
u.nmap("<Leader>f", ":RgContent<CR>")
u.nmap("<Leader>l", ":FzfLua live_grep_native<CR>")
u.nmap(",f", ":Rg<CR>")
u.nmap("<Leader>wf", ":FzfLua grep_cword<CR>")
u.nmap("<Leader>rf", ":FzfLua grep_last<CR>")
u.vmap("<Leader>f", "<ESC> :FzfLua grep_visual<CR>")
u.nmap("<Leader>b", ":FzfLua buffers<CR>")
u.nmap("<Leader>of", ":FzfLua oldfiles<CR>")
u.nmap("<Leader>c", ":FzfLua git_bcommits<CR>")
u.nmap("<Leader>gr", ":LspRef<CR>")
u.nmap("<Leader>ga", ":LspAction<CR>")
u.nmap("<Leader>gd", ":LspDefSplit<CR>")
u.nmap("<Leader>d", ":BSymbols<CR>")
u.nmap("<Leader>ca", ":FzfLua lsp_code_actions<CR>")
u.nmap("<Leader>ch", ":FzfLua git_branches<CR>")
