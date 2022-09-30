local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      before = function (_, vim_item)
        return vim_item
      end
    })
  },
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
    ['<C-Space>'] = cmp.mapping.complete(),
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
    { name = "ultisnips" }
  })
})
