local home = vim.fn.expand("~")

return {
  projects = {
    "C:/Users/fhc/source/repos/lims/Applications/Itga.Lims.ImportEnrobes",
    "C:/Users/fhc/source/repos/pdb-backoffice",
    "C:/Users/fhc/source/repos/pdb-backoffice_POC_GenRapports",
    "C:/Users/fhc/source/repos/rapports.webapi",
    "C:/Users/fhc/source/visuvalid",
    "C:/Users/fhc/source/repos/image.webapi",
    "C:/Users/fhc/source/repos/tools",
    "C:/Users/fhc/source/repos/timetrack",
    "C:/Users/fhc/source/repos/bddlims",
    "C:/Users/fhc/source/repos/Reporting_services",
    "C:/Users/fhc/source/repos/service-enrichissement-de-document",
    "C:/Users/fhc/AppData/Local/nvim",
    "C:/Users/fhc/kanata",
    "//wsl.localhost/Ubuntu/home/fhc/eeznuts",
    "//wsl.localhost/Ubuntu/home/fhc/comp/offpunk",
    "~/.config/nixos-config",
    "~/.config/nvim",
  },
  powershell_profile = [[C:\Users\fhc\psProfile.ps1]],
  dbui_legacy_dir = vim.fs.joinpath(home, ".config", "nvim", "db_ui"),

  vim.api.nvim_create_user_command('FixEncoding', function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local fixed = vim.fn.system('iconv -f latin1 -t utf-8', table.concat(lines, '\n'))
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(fixed, '\n'))
  end, {})

}
