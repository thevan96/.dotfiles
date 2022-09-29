local null_ls = require('null-ls')

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = {
    -- Diagnotics
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.diagnostics.cpplint,
    null_ls.builtins.diagnostics.staticcheck,

    -- Formating
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.golines.with({
      extra_args = { '-m', '80' },
    }),
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.prettier,
  },
  debug = false,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
