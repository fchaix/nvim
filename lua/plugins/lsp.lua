return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Global LSP settings (not server-specific)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Apply to all LSP clients
      vim.lsp.set_log_level("WARN")

      -- You can add default border for hover/signature
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )



      -- Raccourcis claviers LSP
      local opts = { noremap = true, silent = true }
      local keymap = vim.keymap.set

      -- Navigation
      keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Aller à la définition
      keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- Aller à la déclaration
      keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- Voir les références
      keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- Aller à l'implémentation
      keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts) -- Aller à la définition du type

      -- Informations
      keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- Afficher l'info-bulle
      keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- Aide de signature

      -- Actions de code
      keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- Renommer
      keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Actions de code
      keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts) -- Actions de code sur sélection

      -- Diagnostic
      keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- Diagnostic précédent
      keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- Diagnostic suivant
      keymap("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) -- Liste des diagnostics
      keymap("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Diagnostic flottant

      -- Formatage
      keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts) -- Formater le buffer
      keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts) -- Formater la sélection

      -- Workspace
      keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts) -- Ajouter un dossier workspace
      keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts) -- Retirer un dossier workspace
      keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts) -- Lister les dossiers workspace
    end
  }
}
