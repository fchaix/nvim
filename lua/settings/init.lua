require('settings.neovide')

-- cosmétique
vim.opt.title = true -- Afficher le titre de la fenêtre

vim.opt.mouse = 'a' -- Activer la souris dans tous les modes
vim.opt.ignorecase = true -- Ignorer la casse dans les recherches
vim.opt.smartcase = true -- Activer la recherche intelligente (ignore la casse si pas de majuscule)

vim.opt.incsearch = true -- Recherche incrémentale

vim.opt.clipboard = 'unnamedplus' -- Utiliser le presse-papiers système

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

-- Contrôles les splits
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical split' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { noremap = true, silent = true, desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>sc', ':close<CR>', { noremap = true, silent = true, desc = 'Close split' })
vim.keymap.set('n', '<leader>so', ':only<CR>', { noremap = true, silent = true, desc = 'Close other splits' })

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

-- buffer navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Delete buffer' })

vim.cmd [[
  highlight RainbowDelimiterRed guifg=#ff5555
  highlight RainbowDelimiterYellow guifg=#f1fa8c
  highlight RainbowDelimiterBlue guifg=#6272a4
  highlight RainbowDelimiterOrange guifg=#ffb86c
  highlight RainbowDelimiterGreen guifg=#50fa7b
  highlight RainbowDelimiterViolet guifg=#bd93f9
  highlight RainbowDelimiterCyan guifg=#8be9fd
]]

-- Floaterminal 
vim.keymap.set('n', '<leader>tt', function()
  require('settings/floating_terminal').toggle()
end, { noremap = true, silent = true, desc = "Toggle Floating Terminal" })

vim.keymap.set("n", "<leader>ft", ":FloatermToggle<CR>", { desc = "Toggle Floaterm" })
-- key pour toggle Floaterm quand on est en terminal mode
vim.keymap.set("t", "<leader>ft", "<C-\\><C-n>:FloatermToggle<CR>", { desc = "Toggle Floaterm in Terminal Mode" })

-- Folding shit (disabled, using UFO)
--vim.opt.foldmethod = 'indent' -- Use indentation for folding
--vim.opt.foldlevel = 99 -- Start with all folds open
--vim.opt.foldenable = true -- Enable folding by default
--vim.opt.foldcolumn = '0' -- Show fold column

-- Tout est unfold à l'ouverture d'un fichier

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        vim.cmd("normal zR")
    end,
})

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

-- reload config
vim.keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>", { desc = "Reload config" })

-- Raccourcis pour les LSP
-- diagnistics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })


-- Fonction pour exécuter ctags
local function ct()
    vim.cmd("!ctags -R .")
end

-- Exécuter ctags à chaque sauvegarde
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     callback = run_ctags,
-- })

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

-- BufferList
vim.keymap.set('n', '<leader>bb', ':BufferListOpen<CR>', { noremap = true, silent = true, desc = 'List and edit buffers' })

-- switch tabs rapidos

local function goto_or_create_tab(n)
    -- Vérifie si l'onglet n existe
    if n <= vim.fn.tabpagenr('$') then
        vim.cmd(n .. 'tabnext')
    else
        vim.cmd('tabnew')
    end
end

local azerty_tab_mappings = {
    ['&'] = 1,
    ['é'] = 2,
    ['"'] = 3,
    ["'"] = 4,
    ['('] = 5,
    ['-'] = 6,
    ['è'] = 7,
    ['_'] = 8,
    ['ç'] = 9,
    ['à'] = 0,
}

for key, tab_n in pairs(azerty_tab_mappings) do
    vim.keymap.set('n', '<Leader>' .. key, function()
        goto_or_create_tab(tab_n)
    end, { noremap = true, silent = true, desc = 'Aller à l\'onglet ' .. tab_n })
end
