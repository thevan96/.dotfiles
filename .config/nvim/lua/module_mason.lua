require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'html',
    'cssls',
    'jsonls',
    'rust_analyzer',
    'cssmodules_ls',
    'tsserver',
    'gopls',
    'lua_ls',
  },
})
