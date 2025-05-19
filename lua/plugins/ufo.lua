return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },

  event = "BufReadPost", -- Lazy load après ouverture d’un buffer

  config = function()

    -- Réglages globaux
    vim.o.foldcolumn = "1"       -- Colonne des folds (peut être "0", "1", "2", etc.)
    vim.o.foldlevel = 99         -- Tout déplié au départ
    vim.o.foldlevelstart = 99

    vim.o.foldenable = true      -- Active les folds

    -- Setup du plugin
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        -- Treesitter si possible, sinon LSP, sinon indentation
        return { "treesitter", "indent" }
      end,

      open_fold_hl_timeout = 400,

      close_fold_kinds = { "imports", "comment" },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
    })
  end
}

