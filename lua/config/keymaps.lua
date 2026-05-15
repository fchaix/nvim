local map = vim.keymap.set

map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up" })

map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right split" })

map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })

map("n", "<leader>e", function()
  require("oil").open_float()
end, { desc = "Explorer (oil)" })

map("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { desc = "Find files" })
map("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
  require("fzf-lua").help_tags()
end, { desc = "Help tags" })

map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })
map("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
