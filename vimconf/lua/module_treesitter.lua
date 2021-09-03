require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  indent = { enable = false },
  highlight = {
    enable = true,
    disable = { 'yaml' },
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  }
}
