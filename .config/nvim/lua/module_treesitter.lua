require('nvim-treesitter.configs').setup({
  ignore_install = {},
  sync_install = {},
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'vue',
    'go',
  },
  highlight = {
    enable = false,
    disable = {},
  },
  indent = {
    enable = true,
  },
})
