local helper = require("config.plugins.helpers")

local M = {}

local netcoredbg_path = vim.fn.stdpath("data") .. "/netcoredbg/netcoredbg"

function M.setup()
  -- ── nvim-dap ──
  helper.safe_require("dap", function(dap)
    -- Adaptateur .NET (Framework + Core) via netcoredbg
    dap.adapters.netcoredbg = {
      type = "executable",
      command = netcoredbg_path,
      args = { "--interpreter=vscode" },
    }

    -- Configuration de lancement pour une application .NET Framework / Core
    dap.configurations.cs = {
      {
        type = "netcoredbg",
        name = "Launch .NET",
        request = "launch",
        -- programme à debugger : demande le chemin du .exe ou .dll
        program = function()
          return vim.fn.input("Path to dll/exe: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = {},
        cwd = vim.fn.getcwd(),
        stopAtEntry = false,
      },
    }
    -- Idem pour C# (certains LSP signalent 'csharp' comme language)
    dap.configurations.csharp = dap.configurations.cs

    -- Quick fix: ouvrir la fenêtre de logs en cas de pépin
    -- (non mappé ici car <leader>dl est déjà pris par diagnostics)
  end)

  -- ── nvim-dap-ui ──
  helper.safe_require("dapui", function(dapui)
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        -- Naviguer dans les éléments de l'UI
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
      },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.40 },
            { id = "breakpoints", size = 0.20 },
            { id = "stacks",      size = 0.30 },
            { id = "watches",     size = 0.10 },
          },
          size = 50,       -- largeur en colonnes
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 12,       -- hauteur en lignes
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.8,
        max_width = 0.7,
        border = "rounded",
        mappings = { close = { "q", "<Esc>" } },
      },
    })

    -- Auto-ouvrir/fermer l'UI pendant le debug
    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui"] = function()
      dapui.open({ layout = "default" })
    end
    dap.listeners.before.event_terminated["dapui"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui"] = function()
      dapui.close()
    end
  end)

  -- ── nvim-dap-virtual-text ──
  helper.safe_require("nvim-dap-virtual-text", function(dap_vt)
    dap_vt.setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      show_stop_reason = true,
      virt_text_pos = "eol",
      all_frames = false,
    })
  end)
end

return M
