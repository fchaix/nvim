return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- harpoon 2.x (plus moderne)
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()


    -- Keymaps basiques
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
    vim.keymap.set("n", "<leader>&", function() harpoon:list():select(1) end, { desc = "Harpoon go to 1" })
    vim.keymap.set("n", "<leader>é", function() harpoon:list():select(2) end, { desc = "Harpoon go to 2" })
    vim.keymap.set("n", "<leader>\"", function() harpoon:list():select(3) end, { desc = "Harpoon go to 3" })
    vim.keymap.set("n", "<leader>'", function() harpoon:list():select(4) end, { desc = "Harpoon go to 4" })
    vim.keymap.set("n", "<leader>(", function() harpoon:list():select(5) end, { desc = "Harpoon go to 5" })
    vim.keymap.set("n", "<leader>-", function() harpoon:list():select(6) end, { desc = "Harpoon go to 6" })
  end,
}
