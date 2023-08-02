require('oil').setup({
  win_options = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = true,
    conceallevel = 3,
    concealcursor = 'n',
  },
  use_default_keymaps = true,
  delete_to_trash = true,
  trash_command = 'trash-put',
  view_options = {
    show_hidden = true,
  },
})
