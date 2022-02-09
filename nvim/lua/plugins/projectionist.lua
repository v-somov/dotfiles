local utils = require('config.utils')

local function runInTerminal(cmd)
  if vim.api.nvim_win_get_width(0) > 150 then
    vim.cmd("vsplit | term " .. cmd)
  else
    vim.cmd("tabedit | term " .. cmd)
  end

  -- vim.cmd("startinsert")
end

utils.nmap('<leader>.', ':A<cr>')
utils.nmap('<leader>s.', ':AV<cr>')
global.run_current_test_file = function()
  local prg = vim.api.nvim_buf_get_option(0, 'makeprg')
  runInTerminal(prg)
end
utils.lua_command('RunCurrentTestFile', 'global.run_current_test_file()')

global.run_all_test_files = function()
  local prg = vim.api.nvim_buf_get_option(0, 'makeprg')
  runInTerminal(prg .. " --only-failures --fail-fast")
end
utils.lua_command('RunAllTestFiles', 'global.run_all_test_files()')

global.run_current_test_case = function()
  local prg  = vim.api.nvim_buf_get_option(0, 'makeprg')
  local line = vim.api.nvim_win_get_cursor(0)[1]

  runInTerminal(prg .. ":" .. line)
end
utils.lua_command('RunCurrentTestCase', 'global.run_current_test_case()')


utils.nmap(',m', ':RunCurrentTestFile<cr>')
utils.nmap(',a', ':RunAllTestFiles<cr>')
utils.nmap(',.', ':RunCurrentTestCase<cr>')
