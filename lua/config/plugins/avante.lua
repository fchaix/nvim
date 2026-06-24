local helper = require("config.plugins.helpers")

-- ===========================================================================
-- avante.nvim — AI-Powered Coding (Deepseek + OpenAI)
--
-- Providers configurés :
--   • Deepseek (défaut) — via $DEEPSEEK_API_KEY
--   • OpenAI              — via $OPENAI_API_KEY
--
-- Fonctionnalités :
--   • Sidebar chat avec contexte (fichier, sélection, diagnostics)
--   • Éditions inline (sélection → question → apply one-click)
--   • Mode agentic (éditions automatiques multi-fichiers)
--   • Sélection visuelle → question au LLM
--
-- Les sources de complétion pour blink.cmp sont configurées
-- dans lsp.lua (chargé après plugins.lua).
-- ===========================================================================

local M = {}

function M.setup()
  -- render-markdown : nécessaire pour le rendu markdown dans les chats avante
  helper.safe_require("render-markdown", function(rmd)
    rmd.setup({
      file_types = { "markdown", "Avante" },
    })
  end)

  -- img-clip : optionnel, pour le copier-coller d'images
  helper.safe_require("img-clip", function(imgclip)
    imgclip.setup({
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        use_absolute_path = vim.fn.has("win32") == 1,
      },
    })
  end)

  helper.safe_require("avante", function(avante)
    avante.setup({
      -- ── Provider par défaut ──
      provider = "deepseek",

      -- ── Providers HTTP ──
      providers = {
        --- Deepseek V4 Flash (défaut) — rapide & économique, via $DEEPSEEK_API_KEY
        --- Remplace l'ancien deepseek-chat (déprécié le 24/07/2026)
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-v4-flash",
          extra_request_body = {
            max_tokens = 8192,
            temperature = 0.2,
          },
        },
        --- Deepseek V4 Pro — plus puissant (raisonnement complexe), via $DEEPSEEK_API_KEY
        ["deepseek-pro"] = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-v4-pro",
          extra_request_body = {
            max_tokens = 8192,
            temperature = 0.2,
          },
        },
        --- OpenAI / Codex — via $OPENAI_API_KEY
        openai = {
          __inherited_from = "openai",
          api_key_name = "OPENAI_API_KEY",
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o",
          extra_request_body = {
            max_tokens = 4096,
            temperature = 0.2,
          },
        },
      },

      -- ── Providers ACP (Agent Client Protocol) ──
      -- Codex utilise l'authentification OAuth (pas de clé API nécessaire).
      -- Installe le CLI : npm install -g @openai/codex
      -- La 1ère utilisation ouvrira un navigateur pour l'auth OAuth.
      acp_providers = {
        ["codex"] = {
          command = "codex-acp",
          args = {},
          env = {
            NODE_NO_WARNINGS = "1",
          },
        },
      },

      -- ── Comportement ──
      behaviour = {
        -- Suggestions automatiques : désactivées par défaut
        -- (évite les appels API intempestifs et la facture surprise).
        -- Pour activer (Deepseek est rapide et pas cher) :
        --   auto_suggestions = true,
        --   auto_suggestions_provider = "deepseek",
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        minimize_diff = true,
        enable_token_counting = true,
        auto_add_current_file = true,
        auto_approve_tool_permissions = true,
      },

      -- ── Fenêtres ──
      windows = {
        position = "right",
        width = 30,
        wrap = true,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        edit = {
          border = "rounded",
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          border = "rounded",
          focus_on_apply = "ours",
        },
      },

      -- ── Touches ──
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        cancel = {
          normal = { "<C-c>", "<Esc>", "q" },
          insert = { "<C-c>" },
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
        },
      },

      -- ── Sélection visuelle ──
      selection = {
        enabled = true,
      },

      -- ── Fichier d'instructions projet (optionnel) ──
      -- Place un avante.md à la racine de ton projet pour donner du
      -- contexte à l'IA (techno, conventions, architecture…).
      instructions_file = "avante.md",
    })
  end)

  -- ── Keymaps personnalisées ──
  local map = vim.keymap.set

  -- Ouvrir le chat (demande une question en prompt)
  map({ "n", "v" }, "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Avante: Ask" })

  -- Basculer la sidebar
  map("n", "<leader>at", "<cmd>AvanteToggle<CR>", { desc = "Avante: Toggle sidebar" })

  -- Changer de provider rapidement (Deepseek ↔ OpenAI)
  map("n", "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", { desc = "Avante: Switch provider" })

  -- Changer de modèle (ouvre la liste des modèles disponibles)
  map("n", "<leader>am", "<cmd>AvanteModels<CR>", { desc = "Avante: Select model" })
end

return M
