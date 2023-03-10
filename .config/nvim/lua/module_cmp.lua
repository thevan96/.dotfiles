local cmp = require('cmp')

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 50
local MIN_LABEL_WIDTH = 25

cmp.setup({
  formatting = {
    format = function(_, vim_item)
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
      if truncated_label ~= label then
        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
      elseif string.len(label) < MIN_LABEL_WIDTH then
        local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
        vim_item.abbr = label .. padding
      end
      return vim_item
    end,
  },
  preselect = cmp.PreselectMode.None,
  completion = {
    autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-x><C-o>'] = cmp.mapping.complete(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'ultisnips' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  }),
})
