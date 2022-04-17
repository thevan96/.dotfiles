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
    disable = {'yaml'},
    additional_vim_regex_highlighting = false,
  },
}
