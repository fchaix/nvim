local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })
local format_on_save_filetypes = {
  bash = true,
  c = true,
  cpp = true,
  go = true,
  javascript = true,
  javascriptreact = true,
  json = true,
  jsonc = true,
  lua = true,
  sh = true,
  typescript = true,
  typescriptreact = true,
  zsh = true,
}

vim.g.format_on_save = true

vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
  vim.g.format_on_save = not vim.g.format_on_save
  vim.notify("format_on_save=" .. tostring(vim.g.format_on_save))
end, { desc = "Toggle format on save" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    if vim.o.diff then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line = mark[1]
    local last = vim.api.nvim_buf_line_count(0)
    if line > 0 and line <= last then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en,fr"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" or not vim.bo[args.buf].modifiable then
      return
    end

    if not vim.g.format_on_save or vim.b[args.buf].disable_format_on_save then
      return
    end

    local filetype = vim.bo[args.buf].filetype
    if not format_on_save_filetypes[filetype] then
      return
    end

    pcall(vim.lsp.buf.format, {
      bufnr = args.buf,
      timeout_ms = 1500,
      filter = function(client)
        return client:supports_method("textDocument/formatting")
            and client.name ~= "roslyn"
      end,
    })
  end,
})
