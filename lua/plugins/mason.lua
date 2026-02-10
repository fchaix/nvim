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
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
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
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "pyright",
        -- "sqls", -- configuré dans son plugin à côté
    },
  },
}
}
