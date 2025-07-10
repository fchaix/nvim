return {
  'code-biscuits/nvim-biscuits',
  requires = {
    'nvim-treesitter/nvim-treesitter',
     run = ':TSUpdate'
  },
  config = function()
    require('nvim-biscuits').setup({
      default_config = {
        max_length = 12,
        min_distance = 5,
        prefix_string = " 📎 "
      },
    })
  end,
}
