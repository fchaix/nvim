return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = function()
      -- Détection du système d'exploitation
      local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

      -- Définir la commande du shell en fonction de l'OS
      local shell_cmd = is_windows
      and [[powershell.exe -NoLogo -NoExit -Command ". 'C:\Users\fhc\psProfile.ps1'"]]
      or "zsh"

      return {
        size = 80,

        autochdir = true,
        open_mapping = [[<leader>tt]],
        hide_numbers = false, -- hide the number column in toggleterm buffers
        direction = 'float',
        float_opts = {
          border = 'curved',
          winblend = 15,
          highlights = {
            border = 'Normal', 
            background = 'Normal',
          },
        },
        winbar = {
          enabled = false,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end
        },
        shade_terminals = true,
        shading_factor = -50,
        shading_ratio = -3,
        -- Configuration du terminal par défaut
        shell = shell_cmd,
      }
    end
  }
}
