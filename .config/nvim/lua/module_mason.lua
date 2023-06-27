require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'html',
    'cssls',
    'jsonls',
    'rust_analyzer',
    'clangd',
    'cssmodules_ls',
    'pyright',
    'tsserver',
    'gopls',
    'lua_ls',
    'clangd',
  },
})
