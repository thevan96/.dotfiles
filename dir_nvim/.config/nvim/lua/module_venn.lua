function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == 'nil' then
    vim.b.venn_enabled = true
    vim.cmd[[setlocal ve=all]]

    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<C-v>j:VBox<cr>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<C-v>k:VBox<cr>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<C-v>l:VBox<cr>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<C-v>h:VBox<cr>', {noremap = true})

    -- draw a box by pressing 'f' with visual selection
    vim.api.nvim_buf_set_keymap(0, 'v', 'b', ':VBox<cr>', {noremap = true})
    print('Venn mode: ON')
  else
    vim.cmd[[setlocal ve=]]
    vim.cmd[[mapclear <buffer>]]
    vim.b.venn_enabled = nil
    print('Venn mode: OFF')
  end
end

-- toggle keymappings for venn using <leader>V
vim.api.nvim_set_keymap('n', '<leader>D', ':lua Toggle_venn()<cr>', { noremap = true})
