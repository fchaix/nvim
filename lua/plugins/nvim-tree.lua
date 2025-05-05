return {
  'nvim-tree/nvim-tree.lua',
  requires = 'nvim-tree/nvim-web-devicons', -- optionnel, pour les icônes
  config = function()
    require('nvim-tree').setup {}
  end
}

