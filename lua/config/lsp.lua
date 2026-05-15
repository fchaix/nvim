local diagnostic_signs = {
  ERROR = "E",
  WARN = "W",
  INFO = "I",
  HINT = "H",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 2 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.ERROR,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.WARN,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.INFO,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.HINT,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)

  blink.setup({
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = { menu = { auto_show = true } },
    sources = { default = { "lsp", "path", "buffer", "snippets" } },
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
    },
  })
end

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("roslyn", {
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "fullSolution",
      dotnet_compiler_diagnostics_scope = "fullSolution",
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
      dotnet_enable_tests_code_lens = true,
    },
    ["csharp|completion"] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = true,
    },
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_enable_inlay_hints_for_parameters = true,
    },
  },
})

vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

local augroup = vim.api.nvim_create_augroup("UserLsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local opts = { buffer = event.buf, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)

    if client and client.name == "roslyn" then
      local codelens_group = vim.api.nvim_create_augroup("RoslynCodeLens" .. event.buf, { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
        group = codelens_group,
        buffer = event.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = event.buf })
        end,
      })

      vim.lsp.codelens.refresh({ bufnr = event.buf })
    end
  end,
})

vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostics list" })

vim.lsp.enable({ "lua_ls", "pyright", "bashls", "ts_ls", "gopls", "clangd", "roslyn" })
