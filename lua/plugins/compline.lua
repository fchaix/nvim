return {
  "fchaix/Compline",
  priority = 1000,
  config = function()
    vim.o.background = "dark" -- ou "light"
    vim.cmd([[colorscheme compline]])
  end
}
