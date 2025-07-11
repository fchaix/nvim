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
  require('plugins.nvim-tree'),
  require('plugins.gruvbox'),
  require('plugins.lualine'),
  require('plugins.telescope'),
  require('plugins.lspconfig'),
  require('plugins.copilot'),
  require('plugins.oil'),
  require('plugins.toggleterm'),
  require('plugins.rainbow-delimiters'),
  require('plugins.treesitter'),
  require('plugins.firenvim'),
  -- require('plugins.yazi'),
  require('plugins.flash'),
  require('plugins.colorizer'),
  require('plugins.alpha'),
  -- require('plugins.harpoon'),
  require('plugins.dadbod'),
  require('plugins.ufo'),
  require('plugins.csharp'),
  require('plugins.comment'),
  require('plugins.autopairs'),
  require('plugins.gitsigns'),
  require('plugins.trouble'),
  require('plugins.quelleclé'),
  require('plugins.surrounds'),
  require('plugins.marks'),
  require('plugins.floaterm'),
  require('plugins.bufferlist'),
  require('plugins.luasnip'),
  require('plugins.biscuits'),
  -- require('plugins.windsurf'),
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


