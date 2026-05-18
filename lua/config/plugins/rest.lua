local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  helper.safe_require("rest-nvim", function(rest)
    rest.setup({
      result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
        show_statistics = true,
      },
    })

    vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<CR>", { desc = "Run REST request" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "http",
      callback = function(args)
        pcall(vim.treesitter.language.add, "http")
        vim.bo[args.buf].commentstring = "# %s"
      end,
    })
  end)
end

return M
