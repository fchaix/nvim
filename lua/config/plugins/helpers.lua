local M = {}

function M.safe_setup(label, fn)
  local ok, err = pcall(fn)
  if not ok then
    vim.schedule(function()
      vim.notify(("Failed to configure %s: %s"):format(label, err), vim.log.levels.WARN)
    end)
  end
end

function M.safe_require(modname, configure)
  M.safe_setup(modname, function()
    local mod = require(modname)
    if configure then
      configure(mod)
    end
  end)
end

return M
