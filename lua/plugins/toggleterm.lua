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
                size = 20,
                open_mapping = [[<leader>tt]],
                hide_numbers = false, -- hide the number column in toggleterm buffers
                direction = 'float',
                float_opts = {
                    border = 'curved',
                    winblend = 3,
                    highlights = {
                        border = 'Normal', 
                        background = 'Normal',
                    },
                },
                -- Configuration du terminal par défaut
                shell = shell_cmd,
            }
        end
    }
}
