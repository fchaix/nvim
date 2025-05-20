return {
  'numToStr/Comment.nvim',
  lazy = false,
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        enable_autocmd = false,
      },
    },
  },
  config = function()
    require('Comment').setup({
      -- Pour commenter intelligemment selon le langage avec treesitter
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

      -- Tu peux aussi ajouter des mappings ou options ici
      toggler = {
        line = 'gcc',  -- commenter ligne
        block = 'gbc', -- commenter bloc
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },
    })
  end
}
