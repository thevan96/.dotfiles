require('dapui').setup({
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  expand_lines = vim.fn.has('nvim-0.7'),
  layouts = {
    {
      elements = {
        'scopes',
        'stacks',
        'watches',
      },
      size = 0.35,
      position = 'left',
    }
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})
