local actions = require 'telescope.actions'

require('telescope').setup{
  defaults = {
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
      '.git/',
      '.idea/',
      '.vscode/',
      'node_modules/',
      'vendor/',
      'tmp/',
      'composer/',
      'gems/',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    }
  }
}
