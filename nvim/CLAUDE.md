# Neovim Configuration

## Overview

This is a modular Neovim configuration based on the kickstart.nvim pattern, managed as part of a dotfiles repo (`setup-env`). This is the **server** variant — a stripped-down config intended for use on Linux servers, without the desktop-only academic plugins (Obsidian, Papis, VimTeX). For the full desktop config see the `master` branch.

## Deployment

- `configure.sh` — Copies files into `~/.config/nvim/`. Wipes existing config first.
- `revert.sh` — Reverts to the git master version of the config.
- `init.lua` becomes `~/.config/nvim/init.lua`, `config/` and `plugins/` go into `lua/`.

## Architecture

- **Entry point**: `init.lua` — loads config modules, sets Python host via pyenv, bootstraps lazy.nvim.
- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) — plugins auto-discovered from `plugins/` directory via `{ import = "plugins" }`.
- **Config modules** (`config/`): `options.lua`, `keymaps.lua`, `spelling.lua`.
- **Snippets** (`snippets/`): LuaSnip snippets loaded from `~/repos/setup-env/nvim/snippets` (not from the deployed location).

## Key Conventions

- Leader key: `<Space>` (both leader and localleader)
- Nerd Font: enabled (`vim.g.have_nerd_font = true`)
- Indentation: 2 spaces (tabs expanded)
- Fold method: indent, foldlevel 99 (all open by default)
- Colorscheme: Catppuccin Macchiato
- All plugin specs are individual Lua files in `plugins/`, each returning a lazy.nvim spec table

## LSP & Formatting

- LSP servers managed via Mason: `lua_ls`, `ruff`, `pylsp`
- pylsp has all linting plugins disabled (deferred to ruff)
- Formatting via conform.nvim: `stylua` for Lua, `isort` for Python, LSP-first fallback
- Format on save is enabled (except C/C++)

## Completion

- nvim-cmp with sources: LSP, LuaSnip, path, buffer, cmdline
- Markdown filetype adds `render-markdown` source
- LuaSnip keymaps: `<C-y>` expand, `<C-j>`/`<C-k>` jump forward/back, `<C-e>` cycle choices

## Key Plugins

| Plugin | File | Notes |
|--------|------|-------|
| Telescope | `picker.lua` | Fuzzy finder, `<leader>f*` bindings |
| which-key | `whichkey.lua` | Keybinding discovery |
| Gitsigns | `display.lua` | Git hunks, `<leader>h*` bindings |
| Diffview | `git.lua` | `:DiffviewOpen` / `:DiffviewFileHistory` |
| Lualine | `display.lua` | Statusline with Catppuccin theme |
| Noice | `display.lua` | UI for messages/cmdline |
| mini.nvim | `qol.lua` | ai textobjects, surround (vim-surround style: `ys`/`ds`/`cs`/`S`), auto-root |
| Aerial | `aerial.lua` | Code outline |
| Trouble | `trouble.lua` | Diagnostics |
| Yazi | `yazi.lua` | File manager |
| Treesitter | `treesitter.lua` | Syntax |
| undotree | bundled in `init.lua` via `packadd`, `<leader>u` to toggle |

## Telescope Keymaps

- `<leader>ff` Find files
- `<leader>fs` Live grep
- `<leader>fb` Buffers
- `<leader>fh` Help tags
- `<leader>fk` Keymaps
- `<leader>fc` Commands
- `<leader>/` Fuzzy find in current buffer

## Other Notable Keymaps

- `<leader>qq` / `<leader>ql` — Toggle quickfix / loclist
- `<leader>tl` — Toggle diagnostic virtual lines
- `<leader>u` — Toggle undotree
- `<C-h/j/k/l>` — Window navigation
- `gd` / `gr` — LSP go to definition / references
- `<leader>rn` / `<leader>ca` — LSP rename / code action

## Spelling

- Spell check auto-enabled for `.tex` and `.md` files
- Custom spellfiles stored in Dropbox (`~/Dropbox/org/tex/` and `~/Dropbox/org/md/`)

## When Editing This Config

- Each plugin file in `plugins/` must return a valid lazy.nvim spec (table or list of tables)
- After changes, run `configure.sh` to deploy, then restart Neovim
- Snippets are loaded directly from this repo path, not the deployed config
