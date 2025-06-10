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
vim.opt.expandtab = true -- Convertir les tabulations en espaces
-- indentation en 2 espaces pour html
vim.cmd [[ autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab ]]

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
-- vim.api.nvim_create_autocmd("CursorMoved", {
--
--   callback = function()
--     local line = vim.fn.line(".")
--     if line > 10 then  -- ne recentre pas si on est dans les 10 premières lignes
--       vim.cmd("normal! zz")
--
--     end
--   end,
-- })

-- Floaterminal 
vim.keymap.set('n', '<leader>tt', function()
  require('settings/floating_terminal').toggle()
end, { noremap = true, silent = true, desc = "Toggle Floating Terminal" })

-- Folding shit (disabled, using UFO)
--vim.opt.foldmethod = 'indent' -- Use indentation for folding
--vim.opt.foldlevel = 99 -- Start with all folds open
--vim.opt.foldenable = true -- Enable folding by default
--vim.opt.foldcolumn = '0' -- Show fold column

-- Utilisation de treesitter pour fold/unfold des blocs
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- ouvrir les messages d'erreur dans un buffer
vim.api.nvim_create_user_command('MessagesToBuffer', function()
  vim.cmd('redir @a')
  vim.cmd('silent messages')
  vim.cmd('redir END')
  vim.cmd('new')
  vim.cmd('put a')
end, {})

-- Trucs qui s'exécutent uniquement quand je lance nvim sous windows
local uname = vim.loop.os_uname()
local user = os.getenv("USERNAME") or os.getenv("USER") -- Windows utilise USERNAME

if uname.sysname == "Windows_NT" and user == "fhc" then
  -- Forcer l'utilisation de cmd.exe comme shell sous Windows
  -- vim.opt.shell = "cmd.exe"

  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Raccourcis pour les LSP
-- diagnistics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })


-- Fonction pour exécuter ctags
local function run_ctags()
    vim.cmd("!ctags -R .")
end

-- Exécuter ctags à chaque sauvegarde
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = run_ctags,
})

-- afficher les caractères invisibles
vim.opt.list = true
vim.opt.listchars = {
    tab = '▸ ',
    trail = '•',
    extends = '>',
    precedes = '<',
    nbsp = '␣',
    eol = '↲',
    space = '⸱',
}

-- Ignore case on search
vim.opt.ignorecase = true
-- Smart case for search
vim.opt.smartcase = true

-- Write as root
vim.api.nvim_create_user_command('WriteAsRoot', function()
  local file = vim.fn.expand('%:p')
  if file == '' then
    print('No file to write')
    return
  end
  vim.cmd('w !sudo tee ' .. file .. ' > /dev/null')
end, { desc = 'Write current file as root' })

-- racourcis de navigation entre les tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { noremap = true, silent = true, desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tO', ':tabonly<CR>', { noremap = true, silent = true, desc = 'Close other tabs' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { noremap = true, silent = true, desc = 'Next tab' })
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { noremap = true, silent = true, desc = 'Previous tab' })

