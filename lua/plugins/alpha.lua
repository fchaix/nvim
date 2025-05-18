return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ASCII Art (tu peux le personnaliser)
    dashboard.section.header.val = {
       -- https://www.patorjk.com/software/taag/#p=display&f=Ogre&t=Text
[[ _____          _  ]], 
[[/__   \_____  _| |_ ]],
[[  / /\/ _ \ \/ / __|]],
[[ / / |  __/>  <| |_ ]],
[[ \/   \___/_/\_\\__|]],
    }

    -- Boutons personnalisés
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Message en bas
    dashboard.section.footer.val = "Bienvenue sur Neovim ( ͡• ͜ʖ ͡•)"

    alpha.setup(dashboard.opts)
  end,
}

