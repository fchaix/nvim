return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
    "nvim-treesitter/nvim-treesitter", -- scope requiert treesitter
  },
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = { char = ":" }, -- ton choix
    scope = {
      enabled = true,
      show_start = false,      -- optionnel : n'affiche pas le trait au début du scope
      show_end = false,
      show_exact_scope = false,
      -- highlight sera injecté plus bas
    },
  },
  config = function(_, opts)
    local hooks = require("ibl.hooks")
    local ibl = require("ibl")

    -- Noms de groupes utilisés par rainbow-delimiters (par défaut dans le plugin).
    local default_highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }

    -- Si l'utilisateur (ton fichier rainbow) a déjà défini vim.g.rainbow_delimiters,
    -- privilégie cette liste ; sinon fallback sur default_highlight.
    local hl_list = (vim.g.rainbow_delimiters and vim.g.rainbow_delimiters.highlight)
                    or default_highlight

    -- Définit (ou redéfinit) les groupes de highlight à chaque changement de colorscheme.
    -- (La README recommande de le faire via HIGHLIGHT_SETUP.) :contentReference[oaicite:1]{index=1}

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- utiliser les mêmes noms que dans hl_list ; je fournis les couleurs par défaut
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed",    { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue",   { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen",  { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan",   { fg = "#56B6C2" })
    end)

    -- Assure que rainbow-delimiters et ibl partagent la même liste
    vim.g.rainbow_delimiters = vim.g.rainbow_delimiters or {}
    vim.g.rainbow_delimiters.highlight = vim.g.rainbow_delimiters.highlight or hl_list

    opts.scope = opts.scope or {}
    opts.scope.highlight = hl_list

    -- setup ibl avec nos options
    ibl.setup(opts)

    -- **CRUCIAL** : enregistrer ce hook permet à ibl d'utiliser les extmarks/infos
    -- fournis par rainbow-delimiters pour colorer chaque niveau du scope. Sans ça,
    -- ibl n'utilise que le (premier) groupe par défaut. (voir README). :contentReference[oaicite:2]{index=2}
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}

