return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim",
  },
  config = function()
    require("mason").setup()

    -- 🔧 On attend que mason-registry soit prêt
    local registry = require("mason-registry")
    if not registry.is_installed then
      registry.refresh(function()
        require("csharp").setup()
      end)
    else
      require("csharp").setup({
        lsp = {
          omnisharp_cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        }
      })
    end
  end
}
