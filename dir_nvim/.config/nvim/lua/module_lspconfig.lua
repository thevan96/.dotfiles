local nvim_lsp = require('lspconfig')

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'gj', vim.diagnostic.goto_next, opts)

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
end

vim.diagnostic.config({
  signs = true,
  underline = false,
  virtual_text = false,
  update_in_insert = false,
  float = {
    source = 'always',
    border = 'single'
  },
})

local lsp_flags = {
  debounce_text_changes = 50,
}

local on_handlers = {
  ['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
  ['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
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
  'sumneko_lua',
}

local on_capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
on_capabilities.textDocument.completion.completionItem.snippetSupport = true
on_capabilities.offsetEncoding = { 'utf-16' }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = on_capabilities,
    flags = lsp_flags,
    handlers = on_handlers
  }
end

nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- Add border for :LspInfo
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local winopts = _default_opts(options)
  winopts.border = 'rounded'
  return winopts
end