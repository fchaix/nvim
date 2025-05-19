return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },

  event = "BufReadPost",
  config = function()
    -- Options Vim natives pour activer le folding
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    vim.o.foldenable = true

    vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldclose = "", foldsep = " " }
    

    -- Configuration de nvim-ufo
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,


      open_fold_hl_timeout = 400,

      close_fold_kinds_for_ft = {
        -- Fermer automatiquement les "imports" et "comment" dans ces filetypes
        lua = { "imports", "comment" },
        python = { "imports" },
        csharp = { "comment", "using" }, -- J'ai l'impression que ça ne fait rien :/
      },

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
  end,
}

