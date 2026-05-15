vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.autoread = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

local undodir = vim.fs.joinpath(vim.fn.stdpath("state"), "undo")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  trail = "•",
  extends = ">",
  precedes = "<",
  nbsp = "␣",
  eol = "↲",
}
