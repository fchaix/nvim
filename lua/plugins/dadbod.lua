return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",

      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
    end
  }

}
