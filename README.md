# Neovim 0.12 Configuration

This repository contains a Neovim configuration targeting Neovim `0.12` and built around the native `vim.pack` package manager.

## Structure

- [init.lua](/mnt/c/Users/fhc/AppData/Local/nvim/init.lua): entrypoint
- [lua/config/options.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/options.lua): editor options
- [lua/config/autocmds.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/autocmds.lua): autocommands and format-on-save control
- [lua/config/keymaps.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/keymaps.lua): global keymaps
- [lua/config/lsp.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/lsp.lua): LSP, diagnostics, completion
- [lua/config/neovide.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/neovide.lua): Neovide-only settings
- [lua/config/plugins.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/plugins.lua): plugin list and plugin module orchestration
- `lua/config/plugins/`: plugin-specific setup modules
- [lua/config/local.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/local.lua): machine-specific paths and personal project list
- [nvim-pack-lock.json](/mnt/c/Users/fhc/AppData/Local/nvim/nvim-pack-lock.json): pinned plugin revisions

## Plugins

Plugin declarations stay in [lua/config/plugins.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/plugins.lua).
Plugin configuration is split by concern under `lua/config/plugins/`.

Current modules:

- `appearance.lua`: colorscheme, `fzf-lua`, `oil.nvim`, `mini.nvim`
- `projects.lua`: `neovim-project`
- `csharp.lua`: `mason.nvim`, `roslyn.nvim`
- `terminal.lua`: `toggleterm.nvim`
- `dbui.lua`: `vim-dadbod`, `vim-dadbod-ui`, SQL Server compatibility
- `git.lua`: `gitsigns.nvim`
- `helpers.lua`: safe plugin setup helpers with visible notifications on failure

## Local configuration

[lua/config/local.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/local.lua) contains values tied to this machine:

- project roots
- PowerShell profile path
- legacy DBUI directory

If this config is copied to another machine, this file is the first place to adjust.

## Commands

- Start Neovim with this config:

```bash
nvim
```

- Refresh plugins and lockfile:

```bash
nvim --headless "+qa"
```

- Run a basic health check:

```bash
nvim --headless "+checkhealth" +qa
```

## Format on save

Format on save is enabled by default, but only for a whitelist of filetypes defined in [lua/config/autocmds.lua](/mnt/c/Users/fhc/AppData/Local/nvim/lua/config/autocmds.lua).

- Toggle globally:

```vim
:FormatOnSaveToggle
```

- Disable for the current buffer:

```lua
vim.b.disable_format_on_save = true
```

Roslyn is intentionally excluded from automatic format-on-save.

## Notable keymaps

- `<leader>o`: open `oil.nvim` in a floating window
- `<leader>tt`: toggle a floating terminal
- `<leader>pp`: project history
- `<leader>ps`: project discovery
- `<leader>&` to `<leader>à`: jump to AZERTY tab positions 1 to 10

## Validation

Useful checks while editing the config:

```bash
nvim -u NONE -i NONE --headless "+lua vim.opt.runtimepath:prepend('/mnt/c/Users/fhc/AppData/Local/nvim')" "+lua require('config.autocmds')" "+lua require('config.keymaps')" +qa
```

```bash
nvim -u NONE -i NONE --headless "+lua vim.opt.runtimepath:prepend('/mnt/c/Users/fhc/AppData/Local/nvim')" "+lua require('config.local')" "+lua require('config.plugins.helpers')" +qa
```

## Notes

- This config assumes Neovim `0.12+`.
- `vim.pack` writes `nvim-pack-lock.json`; keep it committed when plugin revisions change.
- Some paths are intentionally Windows/WSL-specific because this setup is used from that environment.
