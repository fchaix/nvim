return {
  'nvim-telescope/telescope.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local sorters = require('telescope.sorters')

    telescope.setup{
      defaults = {
        prompt_prefix = '🔍 ',
        winblend = 10,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<c-d>"] = actions.delete_buffer,
          },
          n = {
            ["<c-d>"] = actions.delete_buffer,
            ["dd"] = actions.delete_buffer,
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
        },
        tags = {
          sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
          -- fname_width = 60, -- Limite la largeur du nom de fichier à 60 caractères
        },
      },

      extensions = {
        file_browser = { theme = "ivy" },

      },

    }

    -- Charger les extensions de Telescope ici
    telescope.load_extension('file_browser')

    -- Mappage des raccourcis clavier
    vim.api.nvim_set_keymap(
      'n',
      '<leader>ff',
      -- '<cmd>Telescope find_files<cr>',
      '<cmd>Telescope fd<cr>',
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
      '<leader>fj',
      '<cmd>Telescope jumplist<cr>',
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
    vim.api.nvim_set_keymap(
      'n',
      '<leader>/',
      '<cmd>Telescope current_buffer_fuzzy_find<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fd',
      '<cmd>Telescope diagnostics<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fc',
      '<cmd>Telescope git_commits<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fC',
      '<cmd>Telescope git_bcommits<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fB',
      '<cmd>Telescope git_branches<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fo',
      '<cmd>Telescope oldfiles<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>ft',
      '<cmd>Telescope treesitter<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fs',
      '<cmd>Telescope lsp_document_symbols<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fm',
      '<cmd>Telescope marks<cr>',
      { noremap = true, silent = true }
    )
  end
}

