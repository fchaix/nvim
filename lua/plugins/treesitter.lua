return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "JoosepAlviste/nvim-ts-context-commentstring",
    -- "windwp/nvim-ts-autotag",
    -- "p00f/nvim-ts-rainbow",
    -- "HiRoFaRuTo/firenvim",
  },
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { 
        "c",
        "lua", 
        "vim", 
        "vimdoc", 
        "query", 
        "bash",
        "css",
        "sql",
        "powershell",
        "python", 
        "c_sharp",
        "javascript", 
        "markdown",
        "markdown_inline",
        "html" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["as"] = "@statement.outer",
            ["is"] = "@statement.inner",
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
          },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<D-Space>",
          node_incremental = "<D-Space>",
          scope_incremental = "<TAB>",
          node_decremental = "<D-TAB>",
        },
      },

    })
  end
}
