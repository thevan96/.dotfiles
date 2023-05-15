require('oil').setup({
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-x>'] = 'actions.select_split',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['g.'] = 'actions.toggle_hidden',
  },
  use_default_keymaps = true,
  delete_to_trash = true,
  trash_command = 'trash-put',
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set(
  'n',
  '<leader><BS>',
  require('oil').open,
  { desc = 'Open parent directory' }
)
