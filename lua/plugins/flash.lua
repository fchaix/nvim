return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    highlight = {
      backdrop = true,
      matches = true
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#282828", bg = "#98971A", bold = true })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#555555" })
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#00ffff", bold = true })
  end,
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
