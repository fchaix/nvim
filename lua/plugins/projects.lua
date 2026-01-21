return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "C:/Users/fhc/lims/Applications/Itga.Lims.ImportEnrobes",
      "C:/Users/fhc/source/repos/pdb-backoffice",
      "C:/Users/fhc/source/repos/pdb-backoffice_POC_GenRapports",
      "C:/Users/fhc/source/repos/rapports.webapi",
      "C:/Users/fhc/source/visuvalid",
      "C:/Users/fhc/AppData/Local/nvim",
      "C:/Users/fhc/kanata",
      "//wsl.localhost/Ubuntu/home/fhc/eeznuts"
    },
    patterns = { ".git", "package.json", "*.sln", "Makefile" }, -- détection auto
    project_dir = "~/neovim_projects", -- où sauvegarder les sessions
    silent_chdir = false, -- afficher la notification de changement
    datapath = vim.fn.stdpath("data"),
    picker = {
      type = "telescope", -- ou "fzf-lua", "snacks"
      theme = "dropdown", -- pour telescope
    }
  },
  init = function()
    vim.opt.sessionoptions:append("globals")
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "Shatur/neovim-session-manager",
  },
  lazy = false,
  priority = 100,
  keys = {
    -- Raccourcis clavier pratiques
    { "<leader>pp", "<cmd>Telescope neovim-project history<CR>", desc = "Ouvrir l'historique des projets" },
    { "<leader>ps", "<cmd>Telescope neovim-project discover<CR>", desc = "Découvrir les projets" },
  },
}
