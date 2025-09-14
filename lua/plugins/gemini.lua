return {
  {
    dir = "~/comp/gemini-nvim",
    config = function()
      require("gemini").setup()
    end,
    cmd = { "Gemini", "GeminiFollow", "GeminiBack" },
    ft = { "gemini" },
    -- Optionnel: message d'installation des dépendances
    cond = function()
      local has_socket = pcall(require, "socket")
      local has_ssl = pcall(require, "ssl")
      if not has_socket or not has_ssl then
        vim.notify("Gemini: Installez les dépendances avec: luarocks install luasocket luasec", vim.log.levels.INFO)
      end
      return true -- Toujours charger le plugin
    end
  }
}
