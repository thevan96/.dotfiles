local null_ls = require('null-ls')

local should_enable_eslint = function(utils)
  return utils.root_has_file { 'node_modules/.bin/eslint' }
end

local should_enable_standardjs = function(utils)
  return utils.root_has_file { 'node_modules/.bin/standard' }
end

local should_enable_stylint = function(utils)
  return utils.root_has_file { 'node_modules/.bin/stylelint' }
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    'textDocument/formatting',
    vim.lsp.util.make_formatting_params({}),
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == 'string' and err or err.message
        vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
        return
      end

      if not vim.api.nvim_buf_is_loaded(bufnr)
          or vim.api.nvim_buf_get_option(bufnr, 'modified') then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(
          res, bufnr, client and client.offset_encoding or 'utf-16'
        )
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd('silent noautocmd update')
        end)
      end
    end
  )
end

null_ls.setup({
  sources = {
    -- Diagnotics
    null_ls.builtins.diagnostics.eslint.with {
      condition = should_enable_eslint,
    },
    null_ls.builtins.diagnostics.standardjs.with {
      condition = should_enable_standardjs,
    },
    null_ls.builtins.diagnostics.staticcheck,
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.diagnostics.stylelint.with {
      condition = should_enable_stylint,
    },

    -- Formating
    null_ls.builtins.formatting.eslint.with {
      condition = should_enable_eslint,
    },
    null_ls.builtins.formatting.standardjs.with {
      condition = should_enable_standardjs,
    },
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.clang_format,
  },
  debug = false,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          async_formatting(bufnr)
        end,
      })
    end
  end,
})
