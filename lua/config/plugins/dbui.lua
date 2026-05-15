local helper = require("config.plugins.helpers")
local local_config = require("config.local")

local M = {}

function M.setup()
  helper.safe_setup("vim-dadbod-ui", function()
    local data_dbui_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "db_ui")
    local dbui_dir = vim.fn.filereadable(vim.fs.joinpath(local_config.dbui_legacy_dir, "connections.json")) == 1
        and local_config.dbui_legacy_dir
        or data_dbui_dir

    vim.g.db_ui_save_location = dbui_dir
    vim.fn.mkdir(dbui_dir, "p")

    vim.cmd([[
      function! SQLServerTransform(url, ...)
        if a:url =~? '^sqlserver://'
          let l:url = a:url
          let l:url = substitute(l:url, 'charset=[^&]*', 'charset=CP1252', '')
          if l:url !~? 'charset='
            if l:url =~? '?'
              let l:url = l:url . '&charset=CP1252'
            else
              let l:url = l:url . '?charset=CP1252'
            endif
          endif
          return l:url
        endif
        return a:url
      endfunction

      let g:dadbod_url_transform = 'SQLServerTransform'
    ]])

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      pattern = "*.sql",
      callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        if bufname:match("%.dbout$") then
          return
        end

        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].modifiable then
            vim.bo[args.buf].fileencoding = "cp1252"
          end
        end, 10)
      end,
    })
  end)
end

return M
