local nvim_lsp = require('lspconfig')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'gj', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

vim.diagnostic.config({
  signs = true,
  underline = true,
  severity_sort = true,
  virtual_text = false,
  update_in_insert = false,
  float = {
    source = 'always'
  },
})

local lsp_flags = {
  debounce_text_changes = 150,
}

local servers = {
  'html',
  'clangd',
  'cssls',
  'jsonls',
  'pyright',
  'texlab',
  'tsserver',
  'rust_analyzer',
  'gopls',
}

local on_capabilities = require('cmp_nvim_lsp').
  update_capabilities(vim.lsp.protocol.make_client_capabilities())
on_capabilities.textDocument.completion.completionItem.snippetSupport = false

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = on_capabilities,
    flags = lsp_flags
  }
end
