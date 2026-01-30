return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui"

      -------------------------------------------------------------------
      --- Configuration spécifique pour SQL Server avec encodage CP1252 -
      --- ---------------------------------------------------------------
      -- Transformation d'URL
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

      -- Autocmd sûr qui vérifie le nom du buffer
      vim.api.nvim_create_autocmd({"BufEnter", "FileType"}, {
        pattern = {"*.sql"},
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          -- Appliquer seulement aux buffers qui ne sont pas .dbout
          if not bufname:match("%.dbout$") then
            -- Attendre un peu que le buffer soit complètement chargé
            vim.defer_fn(function()
              if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].modifiable then
                vim.bo[args.buf].fileencoding = "cp1252"
              end
            end, 10)
          end
        end,
      })
    end
  }
}
