require 'nvim-treesitter.configs'.setup({
  ignore_install = {},
  sync_install = {},
  ensure_installed = {
    'html',
    'css',
    'scss',
    'javascript',
    'typescript',
    'tsx',
    'vue',
    'go',
    'rust',
    'http',
    'json',
  },
  highlight = {
    enable = false,
    disable = {},
  },
  indent = {
    enable = true,
  },
})
