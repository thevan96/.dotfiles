local cmp = require('cmp')

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    autocomplete = false
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  mapping =  cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      n = cmp.mapping.close(),
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'tmux' },
  })
})
