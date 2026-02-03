return {
  "rest-nvim/rest.nvim",
  ft = "http",  -- Important : charger seulement pour les fichiers .http
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {  -- Déplacer les keymaps ici
    { "<leader>rr", "<cmd>Rest run<cr>", mode = "n", desc = "Run REST request under cursor" }
  },
  opts = {
    -- Configuration optionnelle
    result = {
      show_url = true,
      show_http_info = true,
      show_headers = true,
      show_statistics = true,
    },
    -- ... autres options
  },
  config = function(_, opts)
    -- Configuration de treesitter
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "http" },
    })
    
    -- Configuration de rest-nvim
    require("rest-nvim").setup(opts)
  end,
}
