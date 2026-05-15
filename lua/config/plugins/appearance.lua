local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  pcall(vim.cmd.colorscheme, "solarized")

  helper.safe_require("fzf-lua")

  helper.safe_require("oil", function(oil)
    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = false,
        natural_order = true,
      },
    })
  end)

  helper.safe_setup("mini.nvim", function()
    require("mini.ai").setup()
    require("mini.comment").setup()
    require("mini.move").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup()
    require("mini.bufremove").setup()
    require("mini.trailspace").setup()
  end)
end

return M
