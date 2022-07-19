local cmp = require('cmp')

cmp.setup({
  completion = {
    autocomplete = false,
    completeopt = 'menu,preview'
    -- keyword_length = 3,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  snippet = {
    expand = function(args)
      -- vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  mapping =  cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      n = cmp.mapping.close(),
    }),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
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
