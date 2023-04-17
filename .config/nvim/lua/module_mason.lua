require 'mason'.setup()
require 'mason-lspconfig'.setup({
  ensure_installed = {
    'rust_analyzer',
    'html',
    'clangd',
    'cssls',
    'cssmodules_ls',
    'jsonls',
    'pyright',
    'tsserver',
    'gopls',
  },
})
