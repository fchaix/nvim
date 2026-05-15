local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  helper.safe_require("gitsigns", function(gitsigns)
    gitsigns.setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },
      current_line_blame = false,
    })

    vim.keymap.set("n", "]h", gitsigns.next_hunk, { desc = "Next hunk" })
    vim.keymap.set("n", "[h", gitsigns.prev_hunk, { desc = "Prev hunk" })
  end)
end

return M
