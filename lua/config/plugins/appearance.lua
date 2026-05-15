local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  pcall(vim.cmd.colorscheme, "solarized")
  vim.api.nvim_set_hl(0, "Whitespace", { link = "Comment" })
  vim.api.nvim_set_hl(0, "NonText", { link = "Comment" })
  vim.api.nvim_set_hl(0, "SpecialKey", { link = "Comment" })

  helper.safe_require("fzf-lua", function(fzf)
    fzf.setup({
      files = {
        hidden = false,
        cwd_prompt = false,
        formatter = "path.filename_first",
      },
      git = {
        files = {
          formatter = "path.filename_first",
        },
      },
      grep = {
        hidden = false,
      },
      lsp = {
        formatter = "path.filename_first",
      },
    })
  end)

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
