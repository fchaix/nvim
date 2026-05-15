local helper = require("config.plugins.helpers")

local M = {}

function M.setup()
  helper.safe_setup("vim-fugitive", function()
    -- Format du message de commit : sur une seule ligne dans la preview
    vim.g.fugitive_summary_format = "(%aD) %s"

    -- Ouvrir le commit sous le curseur dans un onglet vertical
    vim.g.fugitive_open_commit = "vert topleft"

    -- Toujours utiliser des splits horizontaux pour :Git
    vim.g.fugitive_dynamic_width = 0

    -- Keymaps pour fugitive buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitive", "fugitiveblame", "gitcommit", "gitconfig" },
      callback = function(args)
        local opts = { buffer = args.buf, silent = true }

        if vim.bo[args.buf].filetype == "fugitive" then
          -- Rebaseline après un checkout/diff interne
          vim.keymap.set("n", "q", "<cmd>bdelete<CR>", opts)
        end

        if vim.bo[args.buf].filetype == "gitcommit" then
          -- En mode insert, Ctrl+Enter publie le commit
          vim.keymap.set("i", "<C-CR>", "<cmd>wq<CR>", opts)
        end
      end,
    })
  end)
end

return M

