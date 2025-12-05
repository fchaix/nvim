return {
  {
    "wsdjeg/ctags.nvim",
    dependencies = { "wsdjeg/job.nvim" },
    config = function()
      require("ctags").setup({
        -- tu peux passer des options si tu veux personnaliser
        cache_dir = vim.fn.stdpath('data') .. '/ctags.nvim/',
      })
      -- si tu utilises un plugin de type rooter, tu peux par exemple lancer update à chaque changement de projet
      -- require("rooter").reg_callback(require("ctags").update)
    end,
  },
}
