local map = vim.keymap.set

local function in_git_repo()
  return vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" }):match("true") ~= nil
      and vim.v.shell_error == 0
end

local function goto_or_create_tab(n)
  if n == 10 then
    if vim.fn.tabpagenr("$") >= 10 then
      vim.cmd("tabnext 10")
    else
      vim.cmd("tabnew")
    end
    return
  end

  if n <= vim.fn.tabpagenr("$") then
    vim.cmd(n .. "tabnext")
  else
    vim.cmd("tabnew")
  end
end

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

local azerty_tab_mappings = {
  ["&"] = 1,
  ["é"] = 2,
  ['"'] = 3,
  ["'"] = 4,
  ["("] = 5,
  ["-"] = 6,
  ["è"] = 7,
  ["_"] = 8,
  ["ç"] = 9,
  ["à"] = 10,
}

for key, tab_n in pairs(azerty_tab_mappings) do
  map("n", "<leader>" .. key, function()
    goto_or_create_tab(tab_n)
  end, { desc = "Go to tab " .. tab_n })
end

map("n", "<leader>o", function()
  require("oil").open_float()
end, { desc = "Explorer (oil)" })

map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle terminal" })

map("n", "<leader>ff", function()
  local fzf = require("fzf-lua")
  if in_git_repo() then
    fzf.git_files()
  else
    fzf.files()
  end
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

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
