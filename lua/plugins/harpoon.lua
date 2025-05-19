return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",  -- recommander v2 si tu es à jour
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")


    harpoon:setup({
      settings = {

        save_on_toggle = true,
        sync_on_ui_close = true,

      },

    })

    -- Keymaps
    vim.keymap.set("n", "<leader>hp", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Afficher les projets favoris (Harpoon)" })

    vim.keymap.set("n", "<leader>ha", function()

      local cwd = vim.fn.getcwd()
      harpoon:list():append({ value = cwd, context = { cwd = cwd } })
      print("Ajouté : " .. cwd)
    end, { desc = "Ajouter le répertoire courant à Harpoon" })

    -- Naviguer entre les projets
    for i = 1, 5 do
      vim.keymap.set("n", "<leader>" .. i, function()
        local entry = harpoon:list():get(i)
        if entry then
          vim.cmd("cd " .. entry.value)
          print("Répertoire changé : " .. entry.value)
          vim.cmd("Telescope find_files")

        end
      end, { desc = "Changer de projet vers #" .. i })
    end
  end,
}

