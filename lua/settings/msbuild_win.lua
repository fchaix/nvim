-- =============================================================================
-- MSBuild Windows depuis Neovim WSL – version corrigée et fonctionnelle
-- =============================================================================

local M = {}

-- ---------------------------------------------------------------------------
-- MSBuild path (WSL)
-- ---------------------------------------------------------------------------
local MSBUILD =
  "/mnt/c/Program\\ Files/Microsoft\\ Visual\\ Studio/2022/" ..
  "Professional/MSBuild/Current/Bin/MSBuild.exe"

-- ---------------------------------------------------------------------------
-- makeprg
-- ---------------------------------------------------------------------------
vim.opt_local.makeprg =
  [[bash -lc "]] ..
  MSBUILD ..
  [[ $* -nologo -verbosity:minimal 2>&1 \| sed 's/\r$//'"]]

-- ---------------------------------------------------------------------------
-- errorformat (ADAPTÉ À LA SORTIE RÉELLE MSBuild)
-- ---------------------------------------------------------------------------
vim.opt_local.errorformat = table.concat({
  '%-G^||$',                -- lignes || vides
  '|| %f(%l,%c): %m',       -- erreurs C#
  '|| %f(%l): %m',
}, ',')

-- ---------------------------------------------------------------------------
-- Utils chemins
-- ---------------------------------------------------------------------------
local function win_unc_to_wsl(path)
  if not path then return nil end
  path = path:gsub("\\", "/")

  path = path:gsub("^//wsl%.localhost/[^/]+", "")
  return path
end

-- ---------------------------------------------------------------------------
-- Quickfix post-processing
-- ---------------------------------------------------------------------------
function M.fix_qf()
  local items = vim.fn.getqflist()

  for _, it in ipairs(items) do
    if it.filename then
      it.filename = win_unc_to_wsl(it.filename)
      it.bufnr = nil
    end
  end

  vim.fn.setqflist({}, 'r', { items = items })
end

-- ---------------------------------------------------------------------------

-- Autocommand
-- ---------------------------------------------------------------------------
vim.cmd([[
augroup MSBuildWSL
  autocmd!
  autocmd QuickFixCmdPost make lua require('settings.msbuild_win').fix_qf()
augroup END

]])


vim.cmd([[echom "MSBuild WSL chargé (errorformat MSBuild corrigé)"]])

return M


