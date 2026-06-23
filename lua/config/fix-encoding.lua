-- lua/utils/fix-encoding.lua
local mojibake = {
  ['├á'] = 'à', ['├⌐'] = 'é', ['├¿'] = 'è', ['├®'] = 'é',
  ['├¬'] = 'ê', ['├┤'] = 'ô', ['├╗'] = 'û', ['├╝'] = 'ü',
  ['├»'] = 'ï', ['├ª'] = 'æ', ['├╢'] = 'ö', ['├╡'] = 'õ',
  ['ÔÇö'] = '—', ['ÔÇÿ'] = '‘', ['ÔÇÖ'] = '’',
  ['ÔÇ£'] = '“', ['ÔÇ¥'] = '”', ['├é'] = 'Â',
}

vim.api.nvim_create_user_command('FixEncoding', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fixed = {}

  for _, line in ipairs(lines) do
    local result = line
    for bad, good in pairs(mojibake) do
      result = result:gsub(bad, good)
    end
    table.insert(fixed, result)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, fixed)
  vim.notify("Encoding fixed!", vim.log.levels.INFO)
end, {})
