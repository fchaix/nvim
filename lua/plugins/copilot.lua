return {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_enabled = false
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-K>', 'v:lua.copilot_previous()', { expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-L>', 'v:lua.copilot_next()', { expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-E>', 'v:lua.copilot_dismiss()', { expr = true, silent = true })
end
}
