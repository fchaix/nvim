-- Configuration de conform.nvim pour le formatage SQL compatible sqlcmd
return {
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
      -- Ajouter Mason au PATH
      local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
      vim.env.PATH = mason_path .. ";" .. vim.env.PATH

      require("conform").setup({
        formatters_by_ft = {
          ["*"] = { "trim_whitespace" },
          sql = { "sql-formatter" },
        },
        formatters = {
          trim_whitespace = {
            command = nil,
            stdin = false,
          },
          ["sql-formatter"] = {
            command = vim.fn.stdpath("data") .. "/mason/bin/sql-formatter.cmd",
            args = { 
              "--config", 
              -- Configuration JSON sans fonction
              [[{
                "dialect": "tsql",
                "language": "tsql",
                "tabWidth": 4,
                "useTabs": false,
                "keywordCase": "upper",
                "linesBetweenQueries": 1,
                "expressionWidth": 80,
                "denseOperators": false,
                "newlineBeforeSemicolon": false
              }]]
            },
            stdin = true,
            timeout = 2000,
          },
        },
      })

      -- Fonction utilitaire pour nettoyer le SQL avant formatage
      local function preprocess_sql_for_sqlcmd(lines)
        local result = {}
        local i = 1
        while i <= #lines do
          local line = lines[i]

          -- Normaliser les commandes USE
          if line:match("^%s*%[?use%]?%s+%[?.*%]?%s*$") then
            line = line:gsub("%s+", " "):gsub("%s+$", "")
            line = line:upper():gsub("USE", "USE")
          end

          -- S'assurer que GO est sur sa propre ligne
          if line:match("^%s*GO%s*$") then
            if i > 1 and result[#result] ~= "" then
              table.insert(result, "")
            end
            table.insert(result, "GO")
            if i < #lines and lines[i+1] ~= "" then
              table.insert(result, "")
            end
          else
            table.insert(result, line)
          end

          i = i + 1
        end
        return result
      end

      -- Fonction pour formater le SQL avec traitement spécifique sqlcmd
      local function format_sql_with_sqlcmd()
        local buf = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

        -- Prétraitement pour sqlcmd
        local processed_lines = preprocess_sql_for_sqlcmd(lines)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, processed_lines)

        -- Formatage normal avec conform
        require("conform").format({ bufnr = buf })

        -- Post-traitement pour s'assurer que la structure est correcte
        local final_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        final_lines = preprocess_sql_for_sqlcmd(final_lines)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, final_lines)
      end

      -- Commande personnalisée pour formater avec les règles sqlcmd
      vim.api.nvim_create_user_command("FormatSQLcmd", format_sql_with_sqlcmd, {})

      vim.keymap.set("n", "<leader>m", function()
        if vim.bo.filetype == "sql" then
          -- Détection si c'est probablement un fichier avec commandes sqlcmd
          local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
          local has_sqlcmd = false
          for _, line in ipairs(lines) do
            if line:match("^%s*USE%s+%[.*%]") or line:match("^%s*GO%s*$") then
              has_sqlcmd = true
              break
            end
          end

          if has_sqlcmd then
            vim.cmd("FormatSQLcmd")
          else
            require("conform").format()
          end
        else
          require("conform").format()
        end
      end, { desc = "Format buffer (SQL avec règles sqlcmd)" })

      -- Formatage automatique à la sauvegarde pour les fichiers SQL
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.sql",
        callback = function(args)
          -- Vérifier si le fichier semble contenir des commandes sqlcmd
          local lines = vim.api.nvim_buf_get_lines(args.buf, 0, 10, false)
          local has_sqlcmd = false
          for _, line in ipairs(lines) do
            if line:match("^%s*USE%s+%[.*%]") or line:match("^%s*GO%s*$") then
              has_sqlcmd = true
              break
            end
          end

          if has_sqlcmd then
            vim.cmd("FormatSQLcmd")
          else
            require("conform").format({ bufnr = args.buf })
          end
        end,
      })
    end,
  },
}
