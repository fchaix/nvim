return {

  --{'akinsho/toggleterm.nvim', version = "*", config = true}
  -- or
  {'akinsho/toggleterm.nvim', version = "*", opts = {
    size = 20,
    open_mapping = [[<leader>tt]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    direction = 'float',
  }}

}
