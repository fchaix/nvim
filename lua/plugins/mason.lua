return {
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "csharpier",
        "prettier",
        "pyright",
        "roslyn",
        "ruff", -- python linter
        "sqls",
        "stylua",
        "xmlformatter",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "pyright",
        "ruff", -- python linter
        -- "sqls", -- configuré dans son plugin à côté
    },
  },
}
}
