require('vfiler/config').setup({
  options = {
    auto_cd = true,
    auto_resize = true,
    keep = true,
    layout = 'left',
    name = 'explorer',
    width = 35,
    columns = 'indent,icon,name',
    show_hidden_files = true,
  },
})

--- require('vfiler').start()