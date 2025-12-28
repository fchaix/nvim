return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "JoosepAlviste/nvim-ts-context-commentstring",
    -- "windwp/nvim-ts-autotag",
    -- "p00f/nvim-ts-rainbow",
    "glacambre/firenvim",
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
            -- properties
            ["a:"] = "@property.outer",
            ["i:"] = "@property.inner",
            --class
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- statements
            ["as"] = "@statement.outer",
            ["is"] = "@statement.inner",
            -- parameters
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            -- loops
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            -- conditionals
            ["a!"] = "@conditional.outer",
            ["i!"] = "@conditional.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]m"] = "@method.outer",
            ["]c"] = "@class.outer",
            ["]s"] = "@statement.outer",
            ["]p"] = "@parameter.outer",
            ["]l"] = "@loop.outer",
            ["]c"] = "@conditional.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]S"] = "@statement.outer",
            ["]P"] = "@parameter.outer",
            ["]L"] = "@loop.outer",
            ["]C"] = "@conditional.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[s"] = "@statement.outer",
            ["[p"] = "@parameter.outer",
            ["[l"] = "@loop.outer",
            ["[c"] = "@conditional.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[S"] = "@statement.outer",
            ["[P"] = "@parameter.outer",
            ["[L"] = "@loop.outer",
            ["[C"] = "@conditional.outer",
          },
        },
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<leader>dp"] = "@parameter.inner",
        --     ["<leader>dc"] = "@class.inner",
        --     ["<leader>df"] = "@function.inner",
        --     ["<leader>ds"] = "@statement.inner",
        --     ["<leader>dl"] = "@loop.inner",
        --     ["<leader>d!"] = "@conditional.inner",
        --   },
        --   swap_previous = {
        --     ["<leader>dP"] = "@parameter.inner",
        --     ["<leader>dC"] = "@class.inner",
        --     ["<leader>dF"] = "@function.inner",
        --     ["<leader>dS"] = "@statement.inner",
        --     ["<leader>dL"] = "@loop.inner",
        --     ["<leader>d§"] = "@conditional.inner",
        --   },
        -- },
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
