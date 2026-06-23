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
map("n", "<leader>ui", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle invisible chars" })

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
map("n", "<leader>fo", function()
  require("fzf-lua").oldfiles()
end, { desc = "Recent files" })
map("n", "<leader>fh", function()
  require("fzf-lua").help_tags()
end, { desc = "Help tags" })

local function fzf_lsp(method)
  local ok, fzf = pcall(require, "fzf-lua")
  if ok and fzf[method] then
    fzf[method]()
  end
end

map("n", "<leader>ss", function()
  fzf_lsp("lsp_document_symbols")
end, { desc = "LSP document symbols" })
map("n", "<leader>sS", function()
  fzf_lsp("lsp_workspace_symbols")
end, { desc = "LSP workspace symbols" })
map("n", "<leader>sw", function()
  fzf_lsp("lsp_live_workspace_symbols")
end, { desc = "LSP live workspace symbols" })
map("n", "<leader>sd", function()
  fzf_lsp("lsp_definitions")
end, { desc = "LSP definitions" })
map("n", "<leader>sr", function()
  fzf_lsp("lsp_references")
end, { desc = "LSP references" })
map("n", "<leader>si", function()
  fzf_lsp("lsp_implementations")
end, { desc = "LSP implementations" })
map("n", "<leader>st", function()
  fzf_lsp("lsp_typedefs")
end, { desc = "LSP type definitions" })
map("n", "<leader>sf", function()
  fzf_lsp("lsp_finder")
end, { desc = "LSP finder" })
map("n", "<leader>sc", function()
  fzf_lsp("lsp_code_actions")
end, { desc = "LSP code actions" })
map("n", "<leader>sD", function()
  fzf_lsp("diagnostics_document")
end, { desc = "LSP document diagnostics" })
map("n", "<leader>sW", function()
  fzf_lsp("diagnostics_workspace")
end, { desc = "LSP workspace diagnostics" })
map("n", "<leader>sI", function()
  fzf_lsp("lsp_incoming_calls")
end, { desc = "LSP incoming calls" })
map("n", "<leader>sO", function()
  fzf_lsp("lsp_outgoing_calls")
end, { desc = "LSP outgoing calls" })
map("n", "<leader>sU", function()
  fzf_lsp("lsp_type_super")
end, { desc = "LSP supertypes" })
map("n", "<leader>su", function()
  fzf_lsp("lsp_type_sub")
end, { desc = "LSP subtypes" })

map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })
map("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
map("n", "<leader>ga", "<cmd>Git add %<CR>", { desc = "Git add" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })
map("n", "<leader>gP", "<cmd>Git pull<CR>", { desc = "Git pull" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff" })
map("n", "<leader>gD", "<cmd>Gdiffsplit<CR>", { desc = "Git diff (horizontal)" })
map("n", "<leader>gf", "<cmd>Git fetch<CR>", { desc = "Git fetch" })
map("n", "<leader>gS", "<cmd>Git stash<CR>", { desc = "Git stash" })

-- ── Debug (DAP) ──
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  map("n", "<F5>", dap.continue, { desc = "DAP: Continue/Start" })
  map("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
  map("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
  map("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })
  map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
  map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "DAP: Conditional breakpoint" })
  map("n", "<leader>dlp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end, { desc = "DAP: Log point" })
  map("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
  map("n", "<leader>dU", function()
    require("dapui").toggle()
  end, { desc = "DAP: Toggle UI" })
  map({ "n", "v" }, "<leader>dh", dap.run_to_cursor, { desc = "DAP: Run to cursor" })
end

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })


vim.keymap.set('n', '<leader>ww', ':%s/\\r//g<CR>', { desc = 'Supprimer les retours chariot \\r' })
vim.keymap.set('v', '<leader>ww', ':s/\\r//g<CR>', { desc = 'Supprimer \\r dans la sélection' })
