local helper = require("config.plugins.helpers")

local function copy_existing_parser(source, target)
  if vim.fn.filereadable(target) == 0 and vim.fn.filereadable(source) == 1 then
    vim.fn.mkdir(vim.fn.fnamemodify(target, ":h"), "p")
    vim.fn.system({ "cp", source, target })
  end
end

local function ensure_http_parser()
  local parser_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", "nvim-treesitter", "parser")
  local parser_file = vim.fn.has("win32") == 1 and "http.dll" or "http.so"
  local target = vim.fs.joinpath(parser_dir, parser_file)
  if vim.fn.filereadable(target) == 1 then
    return
  end
  local old_parser = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy-rocks", "rest.nvim", "lib", "lua", "5.1", "parser", parser_file)
  copy_existing_parser(old_parser, target)
end

local M = {}

function M.setup()
  ensure_http_parser()

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
  end)
end

return M
