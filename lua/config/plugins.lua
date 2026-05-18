if not vim.pack then
  vim.notify("vim.pack is not available (need Neovim 0.12+)", vim.log.levels.ERROR)
  return
end

local function configure_pack_git_eol()
  if vim.g._pack_git_eol_configured then
    return
  end

  local eol_policy = vim.fn.has("win32") == 1 and "true" or "input"
  local count = tonumber(vim.env.GIT_CONFIG_COUNT or "0") or 0
  vim.env["GIT_CONFIG_KEY_" .. count] = "core.autocrlf"
  vim.env["GIT_CONFIG_VALUE_" .. count] = eol_policy
  vim.env.GIT_CONFIG_COUNT = tostring(count + 1)
  vim.g._pack_git_eol_configured = true
end

configure_pack_git_eol()

vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/coffebar/neovim-project",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/Shatur/neovim-session-manager",
  "https://github.com/seblyng/roslyn.nvim",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/akinsho/toggleterm.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
  "https://github.com/L3MON4D3/LuaSnip",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  "https://github.com/maxmx03/solarized.nvim",
  "https://github.com/tpope/vim-fugitive",
})

require("config.plugins.appearance").setup()
require("config.plugins.projects").setup()
require("config.plugins.csharp").setup()
require("config.plugins.terminal").setup()
require("config.plugins.dbui").setup()
require("config.plugins.git").setup()
require("config.plugins.fugitive").setup()
