local action = require('vfiler/action')

require'vfiler/config'.setup {
  options = {
    auto_cd = false,
    auto_resize = false,
    columns = 'indent,icon,name',
    header = true,
    keep = true,
    listed = true,
    name = '',
    session = 'buffer',
    show_hidden_files = true,
    sort = 'name',
    layout = 'left',
    width = 35,
    new = false,
    quit = true,
    row = 0,
    col = 0,
    blend = 0,
    border = 'rounded',
    zindex = 200,
    git = {
      enabled = false,
      ignored = false,
      untracked = false,
    },
    preview = {
      layout = 'floating',
      width = 0,
      height = 0,
    },
  },
  mappings = {
    ['.'] = action.toggle_show_hidden,
    ['<BS>'] = action.change_to_parent,
    ['<C-l>'] = action.reload,
    ['<C-p>'] = action.toggle_auto_preview,
    ['<C-r>'] = action.sync_with_current_filer,
    ['<C-s>'] = action.toggle_sort,
    ['<CR>'] = action.open,
    ['<Space>'] = function(vfiler, context, view)
      action.toggle_select(vfiler, context, view)
    end,
    ['*'] = action.toggle_select_all,
    ['gg'] = action.move_cursor_top,
    ['b'] = action.list_bookmark,
    ['h'] = action.close_tree_or_cd,
    ['j'] = action.loop_cursor_down,
    ['k'] = action.loop_cursor_up,
    ['l'] = action.open_tree,
    ['mm'] = action.move_to_filer,
    ['p'] = action.toggle_preview,
    ['r'] = action.rename,
    ['s'] = action.open_by_split,
    ['t'] = action.open_by_tabpage,
    ['v'] = action.open_by_vsplit,
    ['x'] = action.execute_file,
    ['yy'] = action.yank_path,
    ['B'] = action.add_bookmark,
    ['C'] = action.copy,
    ['D'] = action.delete,
    ['G'] = action.move_cursor_bottom,
    ['~'] = action.jump_to_home,
    ['J'] = action.jump_to_directory,
    ['K'] = action.new_directory,
    ['L'] = action.switch_to_drive,
    ['M'] = action.move,
    ['N'] = action.new_file,
    ['P'] = action.paste,
    ['q'] = action.quit,
    ['S'] = action.change_sort,
    ['U'] = action.clear_selected_all,
    ['YY'] = action.yank_name,
  },
}
