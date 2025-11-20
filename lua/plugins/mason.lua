return {
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "lua-language-server",
        "xmlformatter",
        "csharpier",
        "prettier",
        "stylua",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "pyright",
        "ruff", -- python linter
        "roslyn",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
}
