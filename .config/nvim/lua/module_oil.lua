require('oil').setup({
  use_default_keymaps = true,
  columns = {
    'icon',
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return name == '..'
    end,
  },
})
