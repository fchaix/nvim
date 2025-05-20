return {
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.defer_fn(function()
      require("colorizer").attach_to_buffer(0)
    end, 100)
  end,
  opts = { -- set to setup table
    RGB = true,
    RRGGBB = true,
    names = false,
    RRGGBBAA = true,
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  },
}
