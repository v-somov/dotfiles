vim.cmd([[
  let dirvish_mode = ':sort | sort ,^.*/,'
]])

local u = require('config.utils')

u.augroup('Dirvish', 'FileType', 'dirvish', 'setlocal relativenumber')
u.nmap('\\', ':Dirvish<cr>')

