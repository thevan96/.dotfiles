local cmp = require('cmp')

cmp.setup({
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  mapping =  cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-x><c-o>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      n = cmp.mapping.close(),
    }),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  })
})
