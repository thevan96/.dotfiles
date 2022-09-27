require 'mason'.setup()
require 'mason-lspconfig'.setup({
  ensure_installed = {
    'sumneko_lua',
    'rust_analyzer',
    'html',
    'clangd',
    'cssls',
    'cssmodules_ls',
    'jsonls',
    'pyright',
    'texlab',
    'tsserver',
    'gopls',
  }
})
