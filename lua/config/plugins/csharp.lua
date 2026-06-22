local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  helper.safe_require("mason", function(mason)
    mason.setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "roslyn",
      },
    })
  end)

  helper.safe_require("roslyn", function(roslyn)
    roslyn.setup({
      -- WSL/Windows file watching can quickly hit inotify limits on large C#
      -- workspaces. Keep Roslyn from owning the watchers by default.
      filewatching = "off",
      broad_search = false,
    })
  end)
end

return M
