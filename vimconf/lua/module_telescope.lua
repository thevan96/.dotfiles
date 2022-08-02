local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical
      }
    },
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    file_ignore_patterns = {
      '.git',
      '.idea',
      '.vscode',
      'node_modules',
      'vendor',
      'tmp',
      'composer',
      'gems',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
}

telescope.load_extension('fzf')
