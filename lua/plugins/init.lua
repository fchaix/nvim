-- Configuration de lazy.nvim ------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- dernière version stable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------------
-- Chargement des plugins via lazy.nvim
---------------------------------------------------------------------
require("lazy").setup({

  ------------------------------------------------------------
  -- ⚙️ Configuration interne de Lazy (ex: protocole git)
  ------------------------------------------------------------
  git = {
    url_format = "git@github.com:%s.git", -- Utilisation par défaut du SSH
  },

  ------------------------------------------------------------
  -- 🎨 Thèmes / Apparence
  ------------------------------------------------------------
  require('plugins.mellifluous'),
  require('plugins.kanagawa-paper'),
  require('plugins.vesper'),
  require('plugins.lackluster'),
  -- require('plugins.eink'),
  -- require('plugins.lualine'),  -- Barre de statut
  require('plugins.colorizer'), -- Colorisation des codes couleurs
  -- require('plugins.compline'),    -- tentative d'adaptation du colorsheme de Joshua Blais
  require('plugins.gruvbox'),
  -- { 'shaunsingh/solarized.nvim' },
  require('plugins.solarized'),
  -- Interface d’accueil :
  require('plugins.alpha'),

  require('plugins.fidgets'),    -- Indicateur d’état LSP

  ------------------------------------------------------------
  -- 🧠 LSP / Auto-complétion / Snippets
  ------------------------------------------------------------
  require('plugins.lsp'),
  require('plugins.roslyn'),      -- LSP C#
  require('plugins.tiny-inline-diagnostics'), -- Diagnostics inline légers
  require('plugins.dap'),         -- Debug Adapter Protocol
  require('plugins.csharp'),      -- Améliorations C#
  require('plugins.cmp'),         -- Completions
  require('plugins.luasnip'),     -- Snippets
  require('plugins.mason'),       -- Gestion des outils LSP/DAP/Linters

  ------------------------------------------------------------
  -- 🔧 Édition / Navigation / Productivité
  ------------------------------------------------------------
  require('plugins.autopairs'),    -- Parenthèses automatiques
  require('plugins.surrounds'),    -- gs... pour gérer les surrounds
  require('plugins.bufferlist'),   -- Gestion de buffers
  require('plugins.telescope'),    -- Fuzzy finder
  require('plugins.oil'),          -- Explorateur de fichiers façon "oil"
  require('plugins.toggleterm'),   -- Terminal intégré
  require('plugins.flash'),        -- Navigation rapide dans le buffer
  require('plugins.comment'),      -- Commentaires faciles
  require('plugins.marks'),        -- Gestion améliorée des marks
  require('plugins.twilight'),     -- Focus du code
  require('plugins.zen-mode'),     -- Mode zen (écriture)
  require('plugins.quelleclé'),    -- Which-key amélioré
  require('plugins.projects'),
  -- Intégration navigateur :
  require('plugins.firenvim'),


  ------------------------------------------------------------
  -- 🔍 Analyse du code / Navigation syntaxique
  ------------------------------------------------------------
  require('plugins.treesitter'),
  require('plugins.trouble'),      -- Liste d’erreurs / warnings / diagnostics
  require('plugins.ctags'),

  ------------------------------------------------------------
  -- 🧩 Git
  ------------------------------------------------------------
  require('plugins.gitsigns'),
  require('plugins.fugitive'),

  ------------------------------------------------------------
  -- 🗄️ Bases de données
  ------------------------------------------------------------
  require('plugins.dadbod'),
  -- require('plugins.sqls'),

  ------------------------------------------------------------
  -- Tests (API, etc)
  ------------------------------------------------------------
  -- require('plugins.rest'),
  require('plugins.http-client'),

  ------------------------------------------------------------
  -- 🚫 Plugins désactivés mais conservés
  -- (classés pour consultation facile)
  ------------------------------------------------------------

  -- Explorateur de fichiers :
  -- require('plugins.nvim-tree'),


  -- Terminal flottant :
  -- require('plugins.floaterm'),

  -- Navigation rapide entre fichiers :
  -- require('plugins.harpoon'),

  -- Folding avancé :
  -- require('plugins.ufo'),

  -- Gestionnaire de fichiers alternatif :
  -- require('plugins.windsurf'),

  -- TUI pour yazi :
  -- require('plugins.yazi'),

  -- Annotations des structures syntaxiques :
  -- require('plugins.biscuits'),

  -- Complétion alternative :
  -- require('plugins.blink'),

  -- Indentation avancée :
  -- require('plugins.ibl'),

  -- Copilot :
  -- require('plugins.copilot'),

  -- Coloration par niveaux de parenthèses :
  require('plugins.rainbow-delimiters'),
})
-- specifics for firenvim
if vim.g.started_by_firenvim then
  vim.o.guifont = "JetBrainsMono Nerd Font:h9" -- Optionnel : police utilisable dans le navigateur
  -- set Copilot disabled in firenvim
  vim.g.copilot_enabled = false

  -- Ajuster les dimensions de l'iframe
  vim.g.firenvim_config = {
    localSettings = {
      [".*"] = {
        takeover = "always", -- Toujours prendre la main quand un champ est focus
        cmdline = "firenvim", -- Ou "firenvim" si tu veux la commande par défaut
        content = "text",
        priority = 0,
        selector = "textarea, div[contenteditable=true]", -- éléments ciblés
        -- ⚠️ ici viennent les options de taille
        -- width = 0.9, -- en pourcentage de la largeur de la fenêtre du navigateur
        -- height = 1, -- en pourcentage de la hauteur
      },
    }
  }
end

-- Conf de copilot
function _G.copilot_previous()
  return vim.fn['copilot#Previous']()
end

function _G.copilot_next()
  return vim.fn['copilot#Next']()
end

function _G.copilot_dismiss()
  return vim.fn['copilot#Dismiss']()
end
function _G.toggle_copilot()

end

