return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()

      vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Ouvrir Fugitive" })
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
      vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
      vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })
      vim.keymap.set("n", "<leader>ga", ":Git add %<CR>", { desc = "Git stage current file" })
    end
  }
}
