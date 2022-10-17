local null_ls = require('null-ls')

local is_in_current_folder = function()
  local file = vim.fn.expand('%:p:h')
  local pwd = vim.fn.getcwd()

  return vim.fn.stridx(file, pwd) >= 0
end

local enable_eslint = function(utils)
  return utils.root_has_file({ 'node_modules/.bin/eslint' })
    and is_in_current_folder
end

local enable_standardjs = function(utils)
  return utils.root_has_file({ 'node_modules/.bin/standard' })
    and is_in_current_folder
end

local enable_prettier = function(utils)
  return utils.root_has_file({ 'node_modules/.bin/prettier' })
    and is_in_current_folder
end

null_ls.setup({
  debug = true,
  sources = {
    -- Diagnotics
    null_ls.builtins.diagnostics.eslint_d.with({
      runtime_condition = enable_eslint,
    }),
    null_ls.builtins.diagnostics.standardjs.with({
      runtime_condition = enable_standardjs,
    }),
    null_ls.builtins.diagnostics.cpplint,
    null_ls.builtins.diagnostics.staticcheck,
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { '--dialect', 'postgres' },
    }),

    -- Code actions
    null_ls.builtins.code_actions.eslint_d.with({
      runtime_condition = enable_eslint,
    }),

    -- Formating
    null_ls.builtins.formatting.rustfmt.with({
      runtime_condition = is_in_current_folder,
    }),
    null_ls.builtins.formatting.gofmt.with({
      runtime_condition = is_in_current_folder,
    }),
    null_ls.builtins.formatting.golines.with({
      extra_args = { '-m', '80' },
      runtime_condition = is_in_current_folder,
    }),
    null_ls.builtins.formatting.clang_format.with({
      runtime_condition = is_in_current_folder,
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint_d.with({
      runtime_condition = enable_eslint,
    }),
    null_ls.builtins.formatting.standardjs.with({
      runtime_condition = enable_standardjs,
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
      },
      runtime_condition = enable_prettier,
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        'css',
        'scss',
        'less',
        'html',
        'json',
        'jsonc',
        'yaml',
        'graphql',
      },
      runtime_condition = is_in_current_folder,
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        'markdown',
        'markdown.mdx',
      },
      runtime_condition = is_in_current_folder,
      extra_args = { '--prose-wrap', 'always' },
    }),
    null_ls.builtins.formatting.sqlfluff.with({
      extra_args = { '--dialect', 'postgres' },
    }),
  },
})
