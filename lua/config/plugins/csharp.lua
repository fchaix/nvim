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
      filewatching = "roslyn",
      broad_search = true,
    })
  end)
end

return M
