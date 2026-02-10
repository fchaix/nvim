return {
  {
    "nanotee/sqls.nvim",
    ft = { "sql", "mysql", "plsql" },
    config = function()
      -- Configuration LSP pour sqls
      require("lspconfig").sqls.setup({
        on_attach = function(client, bufnr)
          -- Mappings personnalisés
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Exécution
          map("n", "<leader>sq", "<cmd>SqlsExecuteQuery<CR>", "Execute SQL query")
          map("x", "<leader>sq", "<cmd>SqlsExecuteQuery<CR>", "Execute selected SQL")
          map("n", "<leader>sl", "<cmd>SqlsExecuteQueryVertical<CR>", "Execute query in vertical split")

          -- Navigation
          map("n", "<leader>sc", "<cmd>SqlsSwitchConnection<CR>", "Switch SQL connection")
          map("n", "<leader>sd", "<cmd>SqlsShowDatabases<CR>", "Show databases")
          map("n", "<leader>st", "<cmd>SqlsShowTables<CR>", "Show tables")
          map("n", "<leader>ss", "<cmd>SqlsShowSchemas<CR>", "Show schemas")

          -- LSP standards
          map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
          map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show documentation")
        end,
      })
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
  },
}
