local helper = require("config.plugins.helpers")

local M = {}

local function get_deepseek_api_key()
  local handle = io.popen("pass show api_keys/deepseek 2>/dev/null")
  if not handle then return nil end
  local key = handle:read("*a"):gsub("%s+", "")
  handle:close()
  return key ~= "" and key or nil
end

function M.setup()
  helper.safe_require("codecompanion", function(codecompanion)
    -- Configuration principale
    codecompanion.setup({
      -- Adaptateur pour DeepSeek
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              -- api_key = os.getenv("DEEPSEEK_API_KEY"),
              api_key = get_deepseek_api_key(),
            },
          })
        end,
      },

      -- Stratégies par défaut
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },

      -- Options générales
      opts = {
        log_level = "INFO", -- ou "DEBUG" pour plus de détails
        send_code = true,    -- Envoyer le code au contexte
      },
    })

    -- Configuration des keymaps
    vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", 
    { desc = "Ouvrir le chat CodeCompanion" })
    vim.keymap.set("n", "<leader>ae", "<cmd>CodeCompanionInline<CR>", 
    { desc = "Édition inline" })
    vim.keymap.set("v", "<leader>ae", "<cmd>CodeCompanionInline<CR>", 
    { desc = "Édition inline (visuel)" })
    vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionAgent<CR>", 
    { desc = "Lancer l'agent" })
    vim.keymap.set("n", "<leader>ad", "<cmd>CodeCompanionActions<CR>", 
    { desc = "Afficher les actions" })
  end)
end

return M
