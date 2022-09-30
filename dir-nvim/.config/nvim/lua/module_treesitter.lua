require'nvim-treesitter.configs'.setup {
  ignore_install = {},
  sync_install = {},
  ensure_installed =  {
    'javascript',
    'typescript',
    'tsx',
    'vue',
    'sql',
    'go',
    'rust',
    'sql',
    'css',
    'scss',
  },
  highlight = {
    enable = false,
    disable = {},
  },
  indent = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}
