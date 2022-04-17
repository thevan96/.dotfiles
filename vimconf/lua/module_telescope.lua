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
      '.git',
      '.vscode',
      '.idea',
      'node_modules',
      'vendor',
      'tmp',
      'composer',
      'gems',
    },
  },
}
