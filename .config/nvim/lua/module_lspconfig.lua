local nvim_lsp = require('lspconfig')

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
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = on_capabilities,
    handlers = on_handlers,
  })
end

nvim_lsp['lua_ls'].setup({
  capabilities = on_capabilities,
  handlers = on_handlers,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>L', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local opts = { buffer = args.buf }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.semanticTokensProvider = nil

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
