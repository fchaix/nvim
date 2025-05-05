return {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-K>', 'copilot#Previous()', { silent = true })
    vim.api.nvim_set_keymap('i', '<C-L>', 'copilot#Next()', { silent = true })
    vim.api.nvim_set_keymap('i', '<C-E>', 'copilot#Dismiss()', { silent = true })
  end
}

