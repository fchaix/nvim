return {
    'github/copilot.vim',
    config = function()
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true })

        vim.api.nvim_set_keymap('i', '<C-K>', '<C-O>:lua copilot_previous()<CR>', { silent = true })
        vim.api.nvim_set_keymap('i', '<C-L>', '<C-O>:lua copilot_next()<CR>', { silent = true })
        vim.api.nvim_set_keymap('i', '<C-E>', '<C-O>:lua copilot_dismiss()<CR>', { silent = true })
    end
}
