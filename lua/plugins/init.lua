-- Configuration de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require('plugins.nvim-tree'),
  require('plugins.gruvbox'),
  require('plugins.lualine'),
  require('plugins.telescope'),
  require('plugins.lspconfig'),
  require('plugins.copilot'),
  require('plugins.oil'),
  require('plugins.toggleterm'),
  require('plugins.rainbow-delimiters'),
  require('plugins.treesitter'),
  require('plugins.firenvim'),
  require('plugins.yazi'),
  require('plugins.flash'),
  require('plugins.colorizer'),
  require('plugins.alpha'),
  require('plugins.harpoon'),
})
