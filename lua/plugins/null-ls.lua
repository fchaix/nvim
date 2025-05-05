return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.dotnet_format,
        null_ls.builtins.diagnostics.dotnet_format,
      },
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.cmd([[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
          ]])
        end
      end,
    })
  end
}

