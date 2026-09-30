local helper = require("config.plugins.helpers")

local M = {}

local palettes = {
  dark = {
    base00 = "#1a1d21", base01 = "#22262b", base02 = "#282c34", base03 = "#3d424a",
    base04 = "#515761", base05 = "#f0efeb", base06 = "#8b919a", base07 = "#e0dcd4",
    base08 = "#cdacac", base09 = "#ccc4b4", base0A = "#d4ccb4", base0B = "#b8c4b8",
    base0C = "#b4c0c8", base0D = "#b4bcc4", base0E = "#b4c4bc", base0F = "#98a4ac",
  },
  light = {
    base00 = "#f0efeb", base01 = "#e0dcd4", base02 = "#e5e3e0", base03 = "#b8b5b0",
    base04 = "#9a9791", base05 = "#1a1d21", base06 = "#5f5c58", base07 = "#2d2a27",
    base08 = "#8b6666", base09 = "#7a6d5a", base0A = "#8b7e52", base0B = "#5a6b5a",
    base0C = "#64757d", base0D = "#5a6b7a", base0E = "#4d6b6b", base0F = "#546470",
  },
}

local function apply_colorscheme()
  local colors = palettes[vim.o.background]
  require("base16-colorscheme").setup(colors)
  -- base16-nvim colors the gutter explicitly; reapply these after every switch
  -- so line numbers and signs always follow the active palette.
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.base04, bg = colors.base00 })
  vim.api.nvim_set_hl(0, "LineNrAbove", { link = "LineNr" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { link = "LineNr" })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.base04, bg = colors.base00 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.base04, bg = colors.base01 })
end

function M.setup()
  -- Compline (dark) and Lauds (light), Joshua Blais.
  -- https://joshblais.com/blog/compline-a-colorscheme-for-deep-contemplation-and-work/
  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = apply_colorscheme,
  })
  apply_colorscheme()
  local themes = { compline = "dark", lauds = "light" }
  vim.api.nvim_create_user_command("Theme", function(opts)
    local background = themes[opts.args]
    if not background then
      error("Theme must be 'compline' or 'lauds'")
    end
    vim.o.background = background
    apply_colorscheme()
  end, { nargs = 1, complete = function() return { "compline", "lauds" } end })
  vim.api.nvim_create_user_command("ThemeToggle", function()
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
    apply_colorscheme()
  end, { desc = "Toggle between Compline and Lauds" })

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
