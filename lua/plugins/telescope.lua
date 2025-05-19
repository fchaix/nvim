return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8', -- ou la dernière version stable
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup{
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        },
        layout_config = {
          horizontal = {
            width = 0.90,
            height = 0.85,
            preview_width = 0.7,
          },
          vertical = {
            width = 0.95,
            height = 0.75,
            preview_height = 0.9,
          },
        },
      },

      pickers = {
        find_files = {
          theme = "dropdown",
        }
      },
      extensions = {
        -- Ajoute ici les extensions de Telescope si nécessaire
      },
    }

    -- Charger les extensions de Telescope ici
    -- telescope.load_extension('extension_name')

    -- Mappage des raccourcis clavier
    vim.api.nvim_set_keymap(
      'n',
      '<leader>ff',
      '<cmd>Telescope find_files<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fg',
      '<cmd>Telescope live_grep<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fb',
      '<cmd>Telescope buffers<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fh',
      '<cmd>Telescope help_tags<cr>',
      { noremap = true, silent = true }
    )
  end
}

