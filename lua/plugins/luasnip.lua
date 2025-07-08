return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets prédéfinis (optionnel)
    config = function()
      local luasnip = require("luasnip")

      -- Charge les snippets depuis friendly-snippets (VS Code-like)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Snippets personnalisés pour C#
      luasnip.add_snippets("cs", {
        luasnip.snippet("class", {
          luasnip.text_node("public class "),
          luasnip.insert_node(1, "MyClass"),
          luasnip.text_node({ " {", "\t" }),
          luasnip.text_node("public "),
          luasnip.insert_node(2, "void"),
          luasnip.text_node(" "),
          luasnip.insert_node(3, "MyMethod"),
          luasnip.text_node({ "() {", "\t\t" }),
          luasnip.insert_node(0),
          luasnip.text_node({ "", "\t}", "}" }),
        }),
      })
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip", -- Intègre LuaSnip avec nvim-cmp
    dependencies = { "hrsh7th/nvim-cmp" }, -- Nécessaire pour cmp_luasnip
  },
}
