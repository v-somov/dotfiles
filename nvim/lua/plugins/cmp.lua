local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = ({
        buffer = "[Buf]",
        tags = "[Tag]",
        nvim_lsp = "[LSP]"
      })
    }),
  },
  completion = {
    keyword_length = 2
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  },
  sources = cmp.config.sources({
    { name = 'buffer' },
    { name = 'nvim_lsp' }
  }, {
    { name = 'tags' }
  })
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
