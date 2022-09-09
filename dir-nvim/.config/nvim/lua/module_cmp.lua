local cmp = require('cmp')

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  mapping =  cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      n = cmp.mapping.close(),
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'tmux' },
  })
})
