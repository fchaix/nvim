return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function (_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,

    -- Horkeys
    vim.api.nvim_set_keymap(
      "n",
      "<leader>rr",
      "<cmd>Rest run<cr>",
      { noremap = true, silent = true, desc = "Run REST request under cursor" }
    ),
  }
}
