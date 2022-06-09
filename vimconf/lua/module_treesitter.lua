require'nvim-treesitter.configs'.setup {
  sync_install = false,
  ignore_install = {},
  ensure_installed = 'all',
  highlight = {
    enable = false,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {
      'yaml',
      'cpp',
      'c',
      'lua',
      'rust',
      'css',
      'scss',
    },
    additional_vim_regex_highlighting = false,
  },
}
