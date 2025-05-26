
return {
  -- Déclaration du plugin
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' }, -- Chargement paresseux
  config = function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Affiche les signes dans la colonne de signe
      numhl      = false, -- Met en surbrillance les numéros de ligne (false ici)
      linehl     = false, -- Met en surbrillance la ligne entière (false ici)
      word_diff  = false, -- Diff au niveau du mot
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Blame virtuel (peut être activé)
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Utilise le format par défaut
      max_file_length = 40000, -- Évite les très gros fichiers
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    --   yadm = {
    --     enable = false
    --   },
    }
  end
}
