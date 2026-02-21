# Neovim Configuration

## Overview

This is a modular Neovim configuration based on the kickstart.nvim pattern, managed as part of a dotfiles repo (`setup-env`). It is tailored for an academic/research workflow (LaTeX, Obsidian notes, Papis citations, Markdown).

## Deployment

- `configure.sh` — Copies files into `~/.config/nvim/`. Wipes existing config first.
- `revert.sh` — Reverts to the git master version of the config.
- `kickstart.lua` becomes `~/.config/nvim/init.lua`, `config/` and `plugins/` go into `lua/`.

## Architecture

- **Entry point**: `kickstart.lua` — loads config modules, sets Python host via pyenv, bootstraps lazy.nvim.
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
- Markdown/vimwiki/yaml filetypes get papis (citations) and omni sources
- LuaSnip keymaps: `<C-y>` expand, `<C-j>`/`<C-k>` jump forward/back, `<C-e>` cycle choices

## Key Plugins

| Plugin | File | Notes |
|--------|------|-------|
| Telescope | `picker.lua` | Fuzzy finder, `<leader>f*` bindings |
| which-key | `whichkey.lua` | Keybinding discovery |
| Obsidian.nvim | `obsidian.lua` | Vault at `~/obsidian/main`, daily notes, meeting templates |
| VimTeX | `vimtex.lua` | LaTeX with latexmk, output to `./tex`, `<localleader>l*` bindings |
| Papis | `papis.lua` | Citation manager integration |
| Gitsigns | `display.lua` | Git hunks, `<leader>h*` bindings |
| Lualine | `display.lua` | Statusline with Catppuccin theme |
| Noice | `display.lua` | UI for messages/cmdline |
| mini.nvim | `qol.lua` | ai textobjects, surround (vim-surround style: `ys`/`ds`/`cs`/`S`), auto-root |
| Aerial | `aerial.lua` | Code outline |
| Trouble | `trouble.lua` | Diagnostics |
| Yazi | `yazi.lua` | File manager |
| Treesitter | `treesitter.lua` | Syntax |

## Telescope Keymaps

- `<leader>ff` Find files
- `<leader>fs` Live grep
- `<leader>fb` Buffers
- `<leader>fh` Help tags
- `<leader>fk` Keymaps
- `<leader>fc` Commands
- `<leader>ft` Obsidian tags
- `<leader>/` Fuzzy find in current buffer

## Other Notable Keymaps

- `<leader>qq` / `<leader>ql` — Toggle quickfix / loclist
- `<leader>tl` — Toggle diagnostic virtual lines
- `<leader>w<leader>w` — Open Obsidian daily note
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
- The surround mappings in `qol.lua` (mini.surround) can conflict with VimTeX's `ds`/`cs` mappings in tex files — VimTeX overrides take priority via which-key buffer-local bindings
