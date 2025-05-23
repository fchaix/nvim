return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = function()
      -- Détection du système d'exploitation
      local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

  --{'akinsho/toggleterm.nvim', version = "*", config = true}
  -- or
  {'akinsho/toggleterm.nvim', version = "*", opts = {
    size = 20,
    open_mapping = [[<leader>tt]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    direction = 'float',
    float_opts = {
      border = 'curved', -- 'curved' | 'double' | 'shadow' | 'none' | 'single' | 'rounded' | 'solid' 
      -- width = 100,
      -- height = 20,
      winblend = 3,
        highlights = {
            border = 'Normal',
            background = 'Normal',
        },
    },
  }}

            return {
                size = 20,
                open_mapping = [[<leader>tt]],
                hide_numbers = true,
                direction = 'float',
                -- Configuration du terminal par défaut
                shell = shell_cmd,
            }
        end
    }
}
