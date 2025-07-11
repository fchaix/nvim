if not vim.g.neovide then
  return
end

-- Font
vim.opt.guifont = "Agave Nerd Font:h12" -- Set your preferred font and size

-- Zooming in and out
vim.api.nvim_set_keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })

-- Animations
vim.g.neovide_cursor_vfx_mode = {"pixiedust", "ripple"}
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_length = 0.1

-- Transparency
vim.g.neovide_opacity= 1
vim.g.transparency = 0.8 -- if you use it for custom themes

-- Scroll animation
vim.g.neovide_scroll_animation_length = 0.2

-- Confirm quit
vim.g.neovide_confirm_quit = true

-- Refresh rate
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5

-- Remember window size
vim.g.neovide_remember_window_size = true

-- Fullscreen toggle example
vim.keymap.set("n", "<F11>", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Toggle fullscreen in Neovide" })


-- Copy paste and stuff
if vim.g.neovide then
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
