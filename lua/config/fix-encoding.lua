local M = {}

local mojibake = {
  -- Latin-1 / cp1252 letters
  ['├á'] = 'à', ['├í'] = 'á', ['├ó'] = 'â', ['├ú'] = 'ã',
  ['├ñ'] = 'ä', ['├Ñ'] = 'å', ['├ª'] = 'æ', ['├º'] = 'ç',
  ['├¿'] = 'è', ['├®'] = 'é', ['├¬'] = 'ê', ['├½'] = 'ë',
  ['├¼'] = 'ì', ['├¡'] = 'í', ['├«'] = 'î', ['├»'] = 'ï',
  ['├▓'] = 'ò', ['├│'] = 'ó', ['├┤'] = 'ô', ['├╡'] = 'õ',
  ['├╢'] = 'ö', ['├╕'] = 'ø', ['├╣'] = 'ù', ['├║'] = 'ú',
  ['├╗'] = 'û', ['├╝'] = 'ü', ['├╜'] = 'ý', ['├╛'] = 'þ',
  ['├┐'] = 'ÿ',

  -- Punctuation and symbols
  ['ÔÇ£'] = '“', ['ÔÇ¥'] = '”', ['ÔÇÿ'] = '‘', ['ÔÇÖ'] = '’', ['ÔÇØ'] = '”',
  ['ÔÇô'] = '–', ['ÔÇö'] = '—', ['ÔÇª'] = '•',
  ['ÔÇ╣'] = '‹', ['ÔÇ║'] = '›', ['Ôé¼'] = '€', ['Ôäó'] = '™',

  -- Leftovers often produced by nbsp / cp1252 bytes
  ['┬á'] = ' ',
  ['┬«'] = '®', ['┬⌐'] = '©', ['┬║'] = 'º', ['┬°'] = '°',

  -- Common stray prefix when UTF-8 bytes were decoded as cp1252 twice
  ['Â '] = ' ', ['Â:'] = ':', ['Â;'] = ';', ['Â!'] = '!',
  ['Â?'] = '?', ['Â»'] = '»', ['Â«'] = '«', ['Â·'] = '·',
  ['Â°'] = '°', ['Â€'] = '€',
}

local replacements = {}
for bad, good in pairs(mojibake) do
  replacements[#replacements + 1] = {
    bad = bad,
    pattern = vim.pesc(bad),
    good = good,
  }
end

table.sort(replacements, function(a, b)
  return #a.bad > #b.bad
end)

function M.fix_line(line)
  local fixed = line

  for _ = 1, 3 do
    local changed = false

    for _, pair in ipairs(replacements) do
      local next_fixed, count = fixed:gsub(pair.pattern, pair.good)
      if count > 0 then
        fixed = next_fixed
        changed = true
      end
    end

    if not changed then
      break
    end
  end

  return fixed
end

function M.fix_range(line1, line2)
  local start_idx = line1 - 1
  local lines = vim.api.nvim_buf_get_lines(0, start_idx, line2, false)
  local fixed_lines = {}
  local changed_lines = 0

  for i, line in ipairs(lines) do
    local fixed = M.fix_line(line)
    fixed_lines[i] = fixed
    if fixed ~= line then
      changed_lines = changed_lines + 1
    end
  end

  if changed_lines == 0 then
    vim.notify('No mojibake fixed in selection', vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(0, start_idx, line2, false, fixed_lines)
  vim.notify(string.format('Encoding fixed on %d/%d line(s)', changed_lines, #fixed_lines), vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('FixEncoding', function(opts)
  M.fix_range(opts.line1, opts.line2)
end, { range = true })

vim.api.nvim_create_user_command('FixEncodingAll', function()
  M.fix_range(1, vim.api.nvim_buf_line_count(0))
end, {})

return M
