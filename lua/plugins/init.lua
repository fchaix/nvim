-- Configuration de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  git = {
    url_format = "git@github.com:%s.git",  -- Format SSH par défaut
  },
  -- require('plugins.nvim-tree'),
  -- require('plugins.alpha'),
  -- require('plugins.firenvim'),
  -- require('plugins.floaterm'),
  -- require('plugins.harpoon'),
  -- require('plugins.lspconfig'),
  -- require('plugins.ufo'), -- pliage de code avancé
  -- require('plugins.windsurf'),
  -- require('plugins.yazi'),
  require('plugins.mason'), -- gestion des marques
  require('plugins.autopairs'), -- gestion des paires de parenthèses, crochets, etc.
  require('plugins.biscuits'),  -- annotations à la fin des blocs (fermeture de parenth_ses, accolades, etc.)
  -- require('plugins.blink'), -- Performant, batteries-included completion plugin for Neovim
  require('plugins.bufferlist'),
  require('plugins.cmp'),
  require('plugins.colorizer'), -- colorize les codes couleurs
  require('plugins.comment'), -- gestion des commentaires
  -- require('plugins.copilot'),
  require('plugins.csharp'),
  require('plugins.dadbod'), -- gestion des bases de données
  require('plugins.flash'),
  require('plugins.gitsigns'), -- gestion des signes git dans la marge
  require('plugins.gruvbox'),
  require('plugins.ibl'), -- Indent Blankline https://github.com/lukas-reineke/indent-blankline.nvim
  require('plugins.lsp'), -- Indent Blankline https://github.com/lukas-reineke/indent-blankline.nvim
  require('plugins.lualine'),
  require('plugins.luasnip'),
  require('plugins.marks'), -- gestion des marques
  require('plugins.oil'),
  require('plugins.quelleclé'),
  require('plugins.rainbow-delimiters'),
  require('plugins.roslyn'), -- gestion des surrounds (parenthèses, guillemets, etc.)
  require('plugins.surrounds'), -- gestion des surrounds (parenthèses, guillemets, etc.)
  require('plugins.telescope'),
  require('plugins.toggleterm'),
  require('plugins.treesitter'),
  require('plugins.trouble'), -- gestion des erreurs et warnings (vérifier si ça marche bien)
  require('plugins.twilight'),
  require('plugins.zen-mode'),
})

-- specifics for firenvim
if vim.g.started_by_firenvim then
  vim.o.guifont = "JetBrainsMono Nerd Font:h9" -- Optionnel : police utilisable dans le navigateur

  -- Ajuster les dimensions de l'iframe
  vim.g.firenvim_config = {
    localSettings = {
      [".*"] = {
        takeover = "always", -- Toujours prendre la main quand un champ est focus
        cmdline = "neovim", -- Ou "firenvim" si tu veux la commande par défaut
        content = "text",
        priority = 0,
        selector = "textarea, div[contenteditable=true]", -- éléments ciblés
        -- ⚠️ ici viennent les options de taille
        width = 0.9, -- en pourcentage de la largeur de la fenêtre du navigateur
        height = 1, -- en pourcentage de la hauteur
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
