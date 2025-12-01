return {
  "datsfilipe/vesper.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("vesper").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      transparent = false, -- Boolean: Sets the background to transparent
      italics = {
        comments = true, -- Boolean: Italicizes comments
        keywords = true, -- Boolean: Italicizes keywords
        functions = true, -- Boolean: Italicizes functions
        strings = true, -- Boolean: Italicizes strings
        variables = true, -- Boolean: Italicizes variables
      },
      overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
      palette_overrides = {}
    })
  end,
}
