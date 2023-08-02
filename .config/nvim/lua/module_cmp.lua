local cmp = require('cmp')

cmp.setup({
  preselect = cmp.PreselectMode.Item,
  completion = {
    autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- ['<C-space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
})
