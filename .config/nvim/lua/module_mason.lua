require 'mason'.setup()
require 'mason-lspconfig'.setup({
  ensure_installed = {
    'lua_ls',
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
