if not vim.pack then
  vim.notify("vim.pack is not available (need Neovim 0.12+)", vim.log.levels.ERROR)
  return
end

local function configure_pack_git_eol()
  if vim.g._pack_git_eol_configured then
    return
  end

  local eol_policy = vim.fn.has("win32") == 1 and "true" or "input"
  local count = tonumber(vim.env.GIT_CONFIG_COUNT or "0") or 0
  vim.env["GIT_CONFIG_KEY_" .. count] = "core.autocrlf"
  vim.env["GIT_CONFIG_VALUE_" .. count] = eol_policy
  vim.env.GIT_CONFIG_COUNT = tostring(count + 1)
  vim.g._pack_git_eol_configured = true
end

configure_pack_git_eol()

vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/coffebar/neovim-project",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/Shatur/neovim-session-manager",
  "https://github.com/seblyng/roslyn.nvim",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/akinsho/toggleterm.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
  "https://github.com/L3MON4D3/LuaSnip",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  "https://github.com/maxmx03/solarized.nvim",
  "https://github.com/tpope/vim-fugitive",
})

pcall(vim.cmd.colorscheme, "solarized")

pcall(function()
  require("mason").setup({
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
    ensure_installed = {
      "roslyn",
    },
  })
end)

pcall(function()
  vim.opt.sessionoptions:append("globals")

  require("neovim-project").setup({
    projects = {
      "C:/Users/fhc/source/repos/lims/Applications/Itga.Lims.ImportEnrobes",
      "C:/Users/fhc/source/repos/pdb-backoffice",
      "C:/Users/fhc/source/repos/pdb-backoffice_POC_GenRapports",
      "C:/Users/fhc/source/repos/rapports.webapi",
      "C:/Users/fhc/source/visuvalid",
      "C:/Users/fhc/source/repos/image.webapi",
      "C:/Users/fhc/source/repos/tools",
      "C:/Users/fhc/source/repos/timetrack",
      "C:/Users/fhc/source/repos/bddlims",
      "C:/Users/fhc/source/repos/Reporting_services",
      "C:/Users/fhc/source/repos/service-enrichissement-de-document",
      "C:/Users/fhc/AppData/Local/nvim",
      "C:/Users/fhc/kanata",
      "//wsl.localhost/Ubuntu/home/fhc/eeznuts",
      "//wsl.localhost/Ubuntu/home/fhc/comp/offpunk",
      "~/.config/nixos-config",
      "~/.config/nvim",
    },
    patterns = { ".git", "package.json", "*.sln", "Makefile" },
    datapath = vim.fn.stdpath("data"),
    silent_chdir = false,
    picker = {
      type = "fzf-lua",
    },
  })
end)

pcall(require, "fzf-lua")

pcall(function()
  require("roslyn").setup({
    filewatching = "roslyn",
    broad_search = true,
  })
end)

pcall(function()
  local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
  local shell_cmd = is_windows and [[powershell.exe -NoLogo -NoExit -Command ". 'C:\Users\fhc\psProfile.ps1'"]] or "zsh"

  require("toggleterm").setup({
    size = 80,
    autochdir = true,
    direction = "float",
    hide_numbers = false,
    float_opts = {
      border = "curved",
      winblend = 15,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end,
    },
    shade_terminals = true,
    shading_factor = -50,
    shading_ratio = -3,
    shell = shell_cmd,
  })
end)

pcall(function()
  local legacy_dbui_dir = vim.fs.joinpath(vim.fn.expand("~"), ".config", "nvim", "db_ui")
  local data_dbui_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "db_ui")
  local dbui_dir = vim.fn.filereadable(vim.fs.joinpath(legacy_dbui_dir, "connections.json")) == 1
      and legacy_dbui_dir
      or data_dbui_dir

  vim.g.db_ui_save_location = dbui_dir
  vim.fn.mkdir(dbui_dir, "p")

  vim.cmd([[
    function! SQLServerTransform(url, ...)
      if a:url =~? '^sqlserver://'
        let l:url = a:url
        let l:url = substitute(l:url, 'charset=[^&]*', 'charset=CP1252', '')
        if l:url !~? 'charset='
          if l:url =~? '?'
            let l:url = l:url . '&charset=CP1252'
          else
            let l:url = l:url . '?charset=CP1252'
          endif
        endif
        return l:url
      endif
      return a:url
    endfunction

    let g:dadbod_url_transform = 'SQLServerTransform'
  ]])

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "*.sql",
    callback = function(args)
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if not bufname:match("%.dbout$") then
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].modifiable then
            vim.bo[args.buf].fileencoding = "cp1252"
          end
        end, 10)
      end
    end,
  })
end)

vim.keymap.set("n", "<leader>pp", "<cmd>NeovimProjectHistory<CR>", { desc = "Open project history" })
vim.keymap.set("n", "<leader>ps", "<cmd>NeovimProjectDiscover<CR>", { desc = "Discover projects" })

pcall(function()
  require("oil").setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = false,
      natural_order = true,
    },
  })
end)

pcall(function()
  require("mini.ai").setup()
  require("mini.comment").setup()
  require("mini.move").setup()
  require("mini.surround").setup()
  require("mini.pairs").setup()
  require("mini.bufremove").setup()
  require("mini.trailspace").setup()
end)

pcall(function()
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "^" },
      changedelete = { text = "~" },
      untracked = { text = "?" },
    },
    current_line_blame = false,
  })

  vim.keymap.set("n", "]h", function()
    require("gitsigns").next_hunk()
  end, { desc = "Next hunk" })

  vim.keymap.set("n", "[h", function()
    require("gitsigns").prev_hunk()
  end, { desc = "Prev hunk" })
end)
