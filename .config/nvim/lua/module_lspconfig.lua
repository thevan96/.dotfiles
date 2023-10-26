local nvim_lsp = require('lspconfig')

vim.diagnostic.config({
  signs = false,
  underline = false,
  virtual_text = false,
  -- {
  --   prefix = '●',
  --   spacing = 2,
  --   source = 'always',
  -- },
  float = {
    source = 'always',
    border = 'single',
  },
  update_in_insert = false,
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

nvim_lsp.html.setup({
  capabilities = on_capabilities,
})

nvim_lsp.jsonls.setup({
  capabilities = on_capabilities,
})

nvim_lsp.cssls.setup({
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

nvim_lsp.lua_ls.setup({
  capabilities = on_capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

nvim_lsp.gopls.setup({})
nvim_lsp.nixd.setup({})
nvim_lsp.cssmodules_ls.setup({})
nvim_lsp.tsserver.setup({})
nvim_lsp.rust_analyzer.setup({})
nvim_lsp.marksman.setup({})
nvim_lsp.bashls.setup({})

-- vim.keymap.set(
--   'n',
--   '[d',
--   '<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>'
-- )
--
-- vim.keymap.set(
--   'n',
--   ']d',
--   '<cmd>lua vim.diagnostic.goto_next({float = false})<cr>'
-- )
vim.keymap.set('n', '<leader>e', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>E', vim.diagnostic.setqflist)

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
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- Disable noise diagnostics neovim lsp
-- vim.api.nvim_create_autocmd({ 'InsertEnter', 'BufEnter' }, {
--   callback = function(args)
--     vim.diagnostic.disable(args.buf)
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
--   callback = function(args)
--     vim.diagnostic.enable(args.buf)
--   end,
-- })

local function get_all_diagnostics(bufnr)
  if vim.tbl_count(vim.lsp.buf_get_clients(bufnr)) == 0 then return '' end

  local error =
    #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
  local warning =
    #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
  local info =
    #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
  local hint =
    #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })

  if error + warning + info + hint == 0 then
    return ''
  end

  return '[🐞/'
    .. error
    .. ' W/'
    .. warning
    .. ' I/'
    .. info
    .. ' H/'
    .. hint
    .. ']'
end

vim.api.nvim_create_autocmd({ 'DiagnosticChanged', 'BufWritePost' }, {
  callback = function(args)
    local error_all = get_all_diagnostics(args.buf)
    vim.wo.statusline = '%<%f ' .. error_all .. ' %h%m%r%=%-14.(%l,%c%V%) %P'
  end,
})
