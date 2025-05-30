return {
  "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ASCII Art (source https://github.com/MaximilianLloyd/ascii.nvim/blob/master/lua/ascii/text/neovim.lua) 
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[  ██████   █████                   █████   █████  ███                  ]],
        [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
        [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
        [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
        [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
        [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
        [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
        [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
        [[                                                                       ]],           
      }

  -- Boutons personnalisés
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

  -- Message en bas
    -- source : https://www.patorjk.com/software/taag/#p=display&f=Tmplr
    -- randomly chose between two messages
    math.randomseed(os.time())
    local messages = {
      {
[[┳┓                        •                   ]], 
[[┃┃┏┓┓┏┏┓┏┓  ┏┓┏┓┏┓┏┓┏┓  ┏┓┓┓┏┏┓  ┓┏┏┓┓┏  ┓┏┏┓ ]], 
[[┛┗┗ ┗┛┗ ┛   ┗┫┗┛┛┗┛┗┗┻  ┗┫┗┗┛┗   ┗┫┗┛┗┻  ┗┻┣┛ ]], 
[[┳┓           ┛          ┓┛        ┛    ┓   ┛  ]], 
[[┃┃┏┓┓┏┏┓┏┓  ┏┓┏┓┏┓┏┓┏┓  ┃┏┓╋  ┓┏┏┓┓┏  ┏┫┏┓┓┏┏┏┓]],
[[┛┗┗ ┗┛┗ ┛   ┗┫┗┛┛┗┛┗┗┻  ┗┗ ┗  ┗┫┗┛┗┻  ┗┻┗┛┗┻┛┛┗]],
[[             ┛                 ┛               ]],
      },
      {
        [[┏ ┳┓┏┳┓┓ ┏ ┓]],
        [[┃ ┣┫ ┃ ┃┃┃ ┃]],
        [[┗ ┻┛ ┻ ┗┻┛ ┛]],
      }
    }

      local random_message = messages[math.random(#messages)]

      dashboard.section.footer.val = random_message
      dashboard.section.footer.opts = {
        position = "center",
        hl = "Type",
      }
    alpha.setup(dashboard.opts)
  end,
}

