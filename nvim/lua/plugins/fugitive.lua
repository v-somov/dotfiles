local u = require('config.utils')

u.augroup('VimFugitive', 'BufReadPost', 'fugitive://* ', 'set bufhidden=delete')
