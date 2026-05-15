local config_root = vim.fn.fnamemodify(vim.env.MYVIMRC or debug.getinfo(1, "S").source:sub(2), ":p:h")
vim.opt.runtimepath:prepend(config_root)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.neovide")
require("config.plugins")
require("config.lsp")
