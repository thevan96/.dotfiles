local nvim_lsp = require('lspconfig')

local opts = { noremap = true, silent = true }
vim.keymap.set(
  'n',
  'gk',
  ':lua vim.diagnostic.goto_prev({ float = false })<cr>',
  opts
)
vim.keymap.set(
  'n',
  'gj',
  ':lua vim.diagnostic.goto_next({ float = false })<cr>',
  opts
)

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  client.server_capabilities.documentFormattingProvider = false

  vim.keymap.set(
    'n',
    'gV',
    ':vsp<cr>:lua vim.lsp.buf.definition()<cr>',
    bufopts
  )
  vim.keymap.set('n', 'gS', ':sp<cr>:lua vim.lsp.buf.definition()<cr>', bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>l', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<space>L', vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
end

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    prefix = '●',
    source = 'always',
  },
  float = {
    source = 'always',
    border = 'single',
  },
})

local servers = {
  'html',
  'cssls',
  'clangd',
  'cssmodules_ls',
  'jsonls',
  'pyright',
  'texlab',
  'tsserver',
  'rust_analyzer',
  'gopls',
  'sumneko_lua',
}

local on_capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
on_capabilities.textDocument.completion.completionItem.snippetSupport = true
on_capabilities.offsetEncoding = { 'utf-16' }

local on_handlers = {
  ['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'single' }
  ),
  ['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'single' }
  ),
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = on_capabilities,
    handlers = on_handlers,
  })
end

nvim_lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
