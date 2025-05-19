require('settings.neovide')

-- Activer la coloration syntaxique
vim.cmd('syntax enable')

-- Activer les numéros de ligne
vim.opt.number = true

-- Activer l'indentation automatique
vim.opt.autoindent = true

-- Activer la mise en évidence de la ligne courante
vim.opt.cursorline = true

-- Définir l'indentation sur 4 espaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Activer le mode relatif des numéros de ligne
vim.opt.relativenumber = true

-- Touche leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Désactiver le son de la touche "backspace"
vim.opt.backspace = 'indent,eol,start'

-- Activer le mode "wrap" pour le texte long
vim.opt.wrap = true

-- Yank to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')

vim.cmd [[
  highlight RainbowDelimiterRed guifg=#ff5555
  highlight RainbowDelimiterYellow guifg=#f1fa8c
  highlight RainbowDelimiterBlue guifg=#6272a4
  highlight RainbowDelimiterOrange guifg=#ffb86c
  highlight RainbowDelimiterGreen guifg=#50fa7b
  highlight RainbowDelimiterViolet guifg=#bd93f9
  highlight RainbowDelimiterCyan guifg=#8be9fd
]]


-- Fonction pour recentrer le curseur sauf si on est proche du début du fichier
vim.api.nvim_create_autocmd("CursorMoved", {

  callback = function()
    local line = vim.fn.line(".")
    if line > 10 then  -- ne recentre pas si on est dans les 10 premières lignes
      vim.cmd("normal! zz")

    end
  end,
})

-- Floaterminal 
vim.keymap.set('n', '<leader>tt', function()
  require('settings/floating_terminal').toggle()
end, { noremap = true, silent = true, desc = "Toggle Floating Terminal" })


