local u = require('config.utils')

local disabledPlugins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
}

for _, plugin in pairs(disabledPlugins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader = " "

global = {}

local set = vim.opt

set.title=true
set.titlestring='%F'

set.laststatus=0

set.hls=true
set.backspace={ 'indent' ,'eol', 'start' }
set.mouse='a'
set.clipboard='unnamed'

set.number=true
set.relativenumber=true

set.ignorecase=true
set.smartcase=true

set.foldmethod='indent'
set.foldenable=false

set.backup=false
set.wb=false
set.swapfile=false

set.errorbells=false
set.visualbell=false
set.autowrite=true
set.wrap=true

set.tabstop=2
set.shiftwidth=2
set.expandtab=true
set.autoindent=true

set.splitright=true
set.splitbelow=true

set.undofile=true
set.undodir=os.getenv("HOME") ..'/.nvim/undo-lua'

u.nmap('n', 'nzz')
u.nmap('N', 'Nzz')
u.nmap(',,', ':noh<CR>')

u.nmap('<up>',    '<C-W>+')
u.nmap('<down>',  '<C-W>-')
u.nmap('<left>',  '3<C-W><')
u.nmap('<right>', '3<C-W>>')

u.cmap('%%', "expand('%:h').'/'", { expr = true })
u.nmap('<leader>cd', ':lcd %:p:h<CR>:pwd<CR>')
u.nmap('<leader><leader>', ':e #<cr>')

u.nmap('<Leader>w', ':w<CR>')
u.nmap('<Leader>q', ':wq<CR>')
u.nmap('<Leader>x', ':bd!<CR>')
u.nmap('<leader>h', ':hide<CR>')
u.nmap('<leader>o', ':only<CR>')

u.nmap('<Leader>r<CR>', '*:%s///g<left><left>')
u.nmap('<Leader>rc<CR>', '*:%s///gc<left><left><left>')
u.nmap('<Leader>gn<CR>', '*:%s///gn<CR>')

u.nmap('<leader>rg', ':FzfLua live_grep <C-R><C-W><CR>')
u.vmap('<leader>rg', 'y:FzfLua live_grep <C-R>"<CR>')

u.nmap('<Leader>p', '"0p')
u.nmap('<Leader>P', '"0P')
u.vmap('<Leader>p', '"0p')

u.vmap('y', 'y`]', { silent = true })
u.vmap('p', 'p`]', { silent = true })
u.nmap('p', 'p`]', { silent = true })

u.augroup('TypescriptFiletypes', 'BufNewFile,BufRead', '*.{ts,tsx}', 'vim.opt.filetype=typescript')

require('config')
require('plugins')
require('lsp')

