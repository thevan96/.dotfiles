local builtin = require('nnn').builtin

require('nnn').setup({
  picker = {
    cmd = 'NNN_TRASH=2 nnn -dH',
    style = {
      width = 0.9,
      height = 0.8,
      xoffset = 0.5,
      yoffset = 0.5,
      border = 'single'
    },
    session = 'shared'
  },
  mappings = {
    { '<C-w>s', builtin.open_in_split },
    { '<C-w>v', builtin.open_in_vsplit },
  },
  replace_netrw = 'picker'
})
