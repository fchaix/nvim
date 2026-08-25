local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  -- Compline Dark (Joshua Blais) — same palette as NixOS Stylix base16Scheme
  -- https://joshblais.com/blog/compline-a-colorscheme-for-deep-contemplation-and-work/
  require("base16-colorscheme").setup({
    base00 = "#1a1d21", -- bg
    base01 = "#22262b", -- bg-alt
    base02 = "#282c34", -- selection
    base03 = "#3d424a", -- comments
    base04 = "#515761", -- dark fg / status bars
    base05 = "#f0efeb", -- fg
    base06 = "#8b919a", -- light fg
    base07 = "#e0dcd4", -- light bg
    base08 = "#cdacac", -- red
    base09 = "#ccc4b4", -- orange
    base0A = "#d4ccb4", -- yellow
    base0B = "#b8c4b8", -- green
    base0C = "#b4c0c8", -- cyan
    base0D = "#b4bcc4", -- blue
    base0E = "#b4c4bc", -- teal
    base0F = "#98a4ac", -- dark-cyan
  })
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
      float = {
        -- wight = 60,
        -- height = 20,
        max_width = 80,
        max_height = 50,
        border = "rounded",   -- "single", "double", "shadow", etc.
        win_options = {
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
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
