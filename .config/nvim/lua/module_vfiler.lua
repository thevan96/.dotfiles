require('vfiler/config').setup({
  options = {
    auto_cd = true,
    auto_resize = true,
    keep = true,
    layout = 'right',
    name = 'explorer',
    width = 40,
    columns = 'indent,icon,name',
    show_hidden_files = true,
  },
})

--- require('vfiler').start()
