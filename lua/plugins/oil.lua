return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    float = {
      padding = 2, -- optionnel : ajoute du padding autour de la fenêtre
      max_width = 80,
      max_height = 50,
      border = "solid", -- ou "single", "double", "solid", etc.
      win_options = {
        winblend = 0,
      },
    },
  },
  dependencies = {
    { "echasnovski/mini.icons", opts = {} }
  },
  lazy = false,
  keys = {
    { "<leader>e", function() require("oil").open_float() end, desc = "Open oil" },
  },
}
