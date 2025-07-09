return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Configuration de Mason
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'omnisharp', 'sqls' }  -- Ajout de sqls ici
    })

    -- Configuration de nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
          { name = 'buffer' },
        })
    })

    -- Configuration de cmp pour les snippets
    cmp.setup.filetype('lua', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
          { name = 'buffer' },
        })
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      }
    }

    -- Fonction d'attachement commune
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      local opts = { noremap=true, silent=true }

      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- Configuration de LSP pour C#
    lspconfig.omnisharp.setup{
      cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) },
      filetypes = { "cs", "vb" },
      root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
      settings = {
        omnisharp = {
          enableRoslynAnalyzers = true,
          organizeImportsOnFormat = true,
          organizeImportsOnSave = true,
          enableEditorConfigSupport = true,
          sdkIncludePrerelease = true,
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Configuration de LSP pour SQL
    lspconfig.sqls.setup {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Configuration spécifique à SQL
        require('sqls').setup {
          -- Vous pouvez ajouter des configurations spécifiques à sqls ici
          -- Par exemple :
          settings = {
            sqls = {
              connections = {
                {
                  -- Exemple de la config
                  -- driver = 'postgresql', -- ou 'mysql', 'sqlite', etc.
                  -- dataSourceName = 'host=localhost port=5432 user=postgres password=postgres dbname=test sslmode=disable',
                  -- Configuration pour MS SQQL Server, utiliser odbc, server=ITGASQLLIMSVALID, database = LIMSVALID, utiliser trusted connextion
                  driver = 'odbc',
                  dataSourceName = 'Driver={ODBC Driver 17 for SQL Server};Server=ITGASQLLIMSVALID;Database=LIMSVALID;Trusted_Connection=yes;',
                },
              },
            },
          },
        }
      end,
      capabilities = capabilities,
    }
  end
}
