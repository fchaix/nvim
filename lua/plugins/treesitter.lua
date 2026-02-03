return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "glacambre/firenvim",
  },
  config = function() 
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
        "yaml",
        "html"
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      markdown = {
        enable = true,
        disable = {},
      },
      indent = { enable = true },  

      textobjects = {
        select = {
          enable = true,
          lookahead = true,

          -- Spécifiquement pour C#
          selection_modes = {
            ['@function.outer'] = 'V',  -- Mode ligne pour les fonctions
            ['@class.outer'] = 'V',     -- Mode ligne pour les classes
            ['@method.outer'] = 'V',    -- Ajoutez ceci aussi
          },

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
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]m"] = "@method.outer",
            ["]c"] = "@class.outer",
            ["]s"] = "@statement.outer",
            ["]p"] = "@parameter.outer",
            ["]l"] = "@loop.outer",
            -- Note: ["]c"] est en double, utilisez une autre touche pour conditional
            ["]!"] = "@conditional.outer",  -- Changé de "]c"
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",        -- Changé de "]c"
            ["]S"] = "@statement.outer",
            ["]P"] = "@parameter.outer",
            ["]L"] = "@loop.outer",
            ["]!"] = "@conditional.outer",  -- Pour la fin aussi
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[s"] = "@statement.outer",
            ["[p"] = "@parameter.outer",
            ["[l"] = "@loop.outer",
            ["[!"] = "@conditional.outer",  -- Changé de "[c"
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",        -- Changé de "[C"
            ["[S"] = "@statement.outer",
            ["[P"] = "@parameter.outer",
            ["[L"] = "@loop.outer",
            ["[!"] = "@conditional.outer",  -- Pour la fin aussi
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
