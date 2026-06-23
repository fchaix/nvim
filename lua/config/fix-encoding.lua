-- lua/utils/fix-encoding.lua
local M = {}

function M.fix_encoding()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fixed_lines = {}

  for _, line in ipairs(lines) do
    local fixed = line
    :gsub('├á', 'à')
    :gsub('├⌐', 'é')
    :gsub('├¿', 'è')
    :gsub('├®', 'é')
    :gsub('├¬', 'ê')
    :gsub('├┤', 'ô')
    :gsub('├╗', 'û')
    :gsub('├╝', 'ü')
    :gsub('├»', 'ï')
    :gsub('├ª', 'æ')
    :gsub('├╢', 'ö')
    :gsub('├╡', 'õ')
    :gsub('ÔÇö', '—')
    :gsub('ÔÇÿ', '‘')
    :gsub('ÔÇÖ', '’')
    :gsub('ÔÇ£', '“')
    :gsub('ÔÇ¥', '”')
    :gsub('├é', 'Â')
    table.insert(fixed_lines, fixed)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, fixed_lines)
  vim.notify("Encoding fixed!", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('FixEncoding', M.fix_encoding, {})

return M
