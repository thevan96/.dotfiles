local nvim_lsp = require('lspconfig')

vim.diagnostic.config({
  signs = false,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    prefix = '●',
    spacing = 2,
    source = 'always',
  },
  float = {
    source = 'always',
    border = 'single',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single',
  })

-- Enable (broadcasting) snippet capability for completion
local on_capabilities = vim.lsp.protocol.make_client_capabilities()
on_capabilities.textDocument.completion.completionItem.snippetSupport = true
on_capabilities.textDocument.completion.completePropertyWithSemicolon = false
on_capabilities.offsetEncoding = { 'utf-16' }

local servers = {
  'cssmodules_ls',
  'pyright',
  'tsserver',
  'rust_analyzer',
  'gopls',
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({})
end

for _, lsp in ipairs({ 'html', 'jsonls' }) do
  nvim_lsp[lsp].setup({
    capabilities = on_capabilities,
  })
end

nvim_lsp['cssls'].setup({
  capabilities = on_capabilities,
  settings = {
    css = {
      completion = {
        completePropertyWithSemicolon = false,
      },
    },
    scss = {
      completion = {
        completePropertyWithSemicolon = false,
      },
    },
  },
})

nvim_lsp['lua_ls'].setup({
  capabilities = on_capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

-- vim.keymap.set(
--   'n',
--   '[d',
--   '<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>'
-- )

-- vim.keymap.set(
--   'n',
--   ']d',
--   '<cmd>lua vim.diagnostic.goto_next({float = false})<cr>'
-- )

-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>Z', vim.diagnostic.setloclist)
-- vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = args.buf }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.semanticTokensProvider = nil

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- Disable noise diagnostics neovim lsp
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

-- vim.api.nvim_create_autocmd({ 'BufWrite' }, {
--   callback = function(args)
--     vim.diagnostic.enable(args.buf)
--   end,
-- })
