local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
  show_hidden_files = true,
  devicons_enable = false,
  mappings = {
    ['<cr>'] = actions.edit,
    ['-'] = actions.up,
    ['<esc>'] = actions.quit,

    ['d'] = actions.mkdir,
    ['%'] = actions.newfile,
    ['R'] = actions.rename,
    ['cd'] = actions.cd,
    ['yp'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,

    ['mf'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['mc'] = clipboard_actions.copy,
    ['mm'] = clipboard_actions.cut,
    ['mt'] = clipboard_actions.paste,
  },
}
