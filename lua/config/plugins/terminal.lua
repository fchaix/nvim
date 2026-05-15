local helper = require("config.plugins.helpers")
local local_config = require("config.local")

local M = {}

function M.setup()
  helper.safe_require("toggleterm", function(toggleterm)
    local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
    local shell_cmd = "zsh"

    if is_windows then
      shell_cmd = ([[powershell.exe -NoLogo -NoExit -Command ". '%s'"]]):format(local_config.powershell_profile)
    end

    toggleterm.setup({
      size = 80,
      autochdir = true,
      direction = "float",
      hide_numbers = false,
      float_opts = {
        border = "curved",
        winblend = 15,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end,
      },
      shade_terminals = true,
      shading_factor = -50,
      shading_ratio = -3,
      shell = shell_cmd,
    })
  end)
end

return M
