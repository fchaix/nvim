local helper = require("config.plugins.helpers")
local local_config = require("config.local")

local M = {}

function M.setup()
  helper.safe_require("neovim-project", function(project)
    vim.opt.sessionoptions:append("globals")

    project.setup({
      projects = local_config.projects,
      patterns = { ".git", "package.json", "*.sln", "Makefile" },
      datapath = vim.fn.stdpath("data"),
      silent_chdir = false,
      picker = {
        type = "fzf-lua",
      },
    })
  end)

  vim.keymap.set("n", "<leader>pp", "<cmd>NeovimProjectHistory<CR>", { desc = "Open project history" })
  vim.keymap.set("n", "<leader>ps", "<cmd>NeovimProjectDiscover<CR>", { desc = "Discover projects" })
end

return M
