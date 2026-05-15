if not vim.g.neovide then
  return
end

local map = vim.keymap.set

vim.opt.guifont = "FantasqueSansM Nerd Font:h14"

vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0
local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

map("n", "<C-=>", function()
  change_scale_factor(1.25)
end, { desc = "Neovide zoom in" })
map("n", "<C-->", function()
  change_scale_factor(1 / 1.25)
end, { desc = "Neovide zoom out" })
map("n", "<C-0>", function()
  vim.g.neovide_scale_factor = 1.0
end, { desc = "Neovide zoom reset" })

vim.g.neovide_cursor_vfx_mode = { "pixiedust", "ripple" }
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_scroll_animation_length = 0.2

vim.g.neovide_opacity = 1.0
vim.g.transparency = 0.8
vim.g.neovide_confirm_quit = true
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_remember_window_size = true

map("n", "<F11>", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Toggle fullscreen in Neovide" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("v", "<C-S-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<C-S-v>", '"+P', { desc = "Paste from system clipboard" })
map("c", "<C-S-v>", "<C-R>+", { desc = "Paste from system clipboard" })
map("c", "<C-v>", "<C-R>+", { desc = "Paste from system clipboard" })
map("i", "<C-S-v>", "<C-R>+", { desc = "Paste from system clipboard" })
map("i", "<C-v>", "<C-R>+", { desc = "Paste from system clipboard" })
map("t", "<C-S-v>", '<C-\\><C-n>"+Pi', { desc = "Paste from system clipboard" })

map({ "n", "i", "v", "c", "t" }, "<D-v>", function()
  vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end, { desc = "Paste from system clipboard" })
