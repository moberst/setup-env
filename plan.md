# Plan: Migrate from lazy.nvim to vim.pack

## Background

`vim.pack` is the built-in plugin manager shipping with Neovim 0.12+. It provides a minimal API (`vim.pack.add`, `vim.pack.update`, `vim.pack.del`) and manages plugins in `site/pack/core/opt/` with a JSON lockfile. This migration will simplify the config by removing the lazy.nvim bootstrap and converting all plugin specs to `vim.pack.add()` calls.

## Key Differences from lazy.nvim

| Concern | lazy.nvim | vim.pack |
|---------|-----------|----------|
| Installation | Bootstrap clone + `require("lazy").setup()` | Built-in, just call `vim.pack.add()` |
| Plugin specs | Table with `config`, `opts`, `dependencies`, `event`, `ft`, `build` | Just a URL string or `{ src, version, name }` |
| Lazy loading | Automatic via `event`, `ft`, `keys`, `cmd` triggers | Manual via `packadd` or use `mini.deps` `now()`/`later()` |
| Configuration | Inline `config` functions in spec tables | Separate setup calls after `vim.pack.add()` |
| Build hooks | `build = ":TSUpdate"` | `PackChanged` / `PackChangedPre` autocommands |
| UI | Rich dashboard with install/update/profile | `:vim.pack.update()` shows diff buffer |

## Architecture After Migration

```
nvim/
├── kickstart.lua              (init.lua — loads options, keymaps, then plugins)
├── configure.sh               (updated deployment script)
├── revert.sh
├── config/
│   ├── options.lua            (unchanged)
│   ├── keymaps.lua            (unchanged)
│   └── spelling.lua           (unchanged)
├── plugins/
│   ├── init.lua               (NEW: master file calling vim.pack.add + all plugin setup)
│   ├── lsp.lua                (config function only, no lazy spec wrapper)
│   ├── autocompletion.lua     (config function only)
│   ├── autoformat.lua         (config function only)
│   ├── treesitter.lua         (config function only)
│   ├── picker.lua             (config function only)
│   ├── display.lua            (config function only)
│   ├── whichkey.lua           (config function only)
│   ├── qol.lua                (config function only)
│   ├── obsidian.lua           (config function only)
│   ├── trouble.lua            (config function only)
│   ├── aerial.lua             (config function only)
│   ├── terminal.lua           (config function only)
│   ├── yazi.lua               (config function only)
│   ├── vimtex.lua             (config function only)
│   ├── markdown-utils.lua     (config function only)
│   ├── papis.lua              (config function only)
│   ├── dashboard.lua          (config function only)
│   ├── lazy-dev.lua           (config function only)
│   └── utils.lua              (config function only)
└── snippets/                  (unchanged)
```

## Step-by-Step Plan

### Step 1: Rewrite `kickstart.lua` (entry point)

Remove the lazy.nvim bootstrap (lines 6-38). Replace with:

```lua
require("config.options")
require("config.keymaps")
require("config.spelling")
vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/nvim/bin/python3")

-- Load all plugins via vim.pack and configure them
require("plugins")
```

### Step 2: Create `plugins/init.lua` — the central plugin manifest

This file will:
1. Call `vim.pack.add()` with ALL plugin URLs
2. Set up `PackChanged` autocommands for build hooks (e.g., TSUpdate)
3. Require each plugin config module in the correct order

```lua
-- Install/register all plugins
vim.pack.add({
  -- Colorscheme (loaded first)
  "https://github.com/catppuccin/nvim",

  -- Core
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",

  -- Navigation & search
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Editing
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/tpope/vim-unimpaired",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/stevearc/dressing.nvim",

  -- LSP & diagnostics
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/stevearc/aerial.nvim",

  -- Terminal & file manager
  "https://github.com/akinsho/toggleterm.nvim",
  "https://github.com/mikavilpas/yazi.nvim",

  -- Writing & research
  "https://github.com/epwalsh/obsidian.nvim",
  "https://github.com/jghauser/papis.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/preservim/vim-markdown",
  "https://github.com/godlygeek/tabular",
  "https://github.com/lervag/vimtex",

  -- Dashboard
  "https://github.com/folke/snacks.nvim",

  -- Dependencies
  "https://github.com/kkharber/sqlite.lua",
  "https://github.com/pysan3/pathlib.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native.nvim" },

  -- Diff view
  "https://github.com/sindrets/diffview.nvim",
})

-- Build hooks via PackChanged
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" then
      vim.cmd("TSUpdate")
    end
    if ev.data.spec.name == "telescope-fzf-native.nvim" then
      -- Rebuild fzf native extension
      vim.fn.system({ "make", "-C", ev.data.path })
    end
  end,
})

-- Configure plugins in dependency order
require("plugins.qol")          -- colorscheme + mini (load first for theme)
require("plugins.lazy-dev")
require("plugins.autocompletion")
require("plugins.lsp")
require("plugins.autoformat")
require("plugins.treesitter")
require("plugins.picker")
require("plugins.display")
require("plugins.whichkey")
require("plugins.obsidian")
require("plugins.trouble")
require("plugins.aerial")
require("plugins.terminal")
require("plugins.yazi")
require("plugins.vimtex")
require("plugins.markdown-utils")
require("plugins.papis")
require("plugins.dashboard")
require("plugins.utils")
```

### Step 3: Convert each plugin file from lazy.nvim spec to plain config

Each file currently returns a lazy.nvim spec table like:
```lua
return {
  "plugin/name",
  dependencies = { ... },
  opts = { ... },
  config = function() ... end,
}
```

Convert to a plain module that just configures the plugin:
```lua
-- No return needed, just setup calls
require("plugin-name").setup({ ... })
-- keymaps, autocommands, etc.
```

**For each of the ~20 plugin files:**
- Remove the `return { ... }` lazy spec wrapper
- Remove `dependencies` keys (handled centrally in `plugins/init.lua`)
- Keep the `config` function body as top-level code
- For plugins using `opts = {}`, convert to `require("plugin").setup({})`
- For plugins with `event`/`ft`/`keys` lazy-loading triggers — just load eagerly (vim.pack doesn't have built-in lazy loading; most plugins are fast enough)

### Step 4: Handle special cases

#### a. Treesitter build hook
Currently `build = ":TSUpdate"`. Replace with a `PackChanged` autocommand (shown in Step 2).

#### b. telescope-fzf-native build
Currently `build = "make"`. Replace with a `PackChanged` autocommand.

#### c. Obsidian local dev plugin
Currently `dev = true` loads from `~/repos/nvim-local`. For vim.pack, we can either:
- Use a symlink in the pack directory, OR
- Add it with a local path/file URI

#### d. Colorscheme priority
Catppuccin currently has `priority = 1000` in lazy.nvim. In the new setup, we ensure it's configured first by putting `require("plugins.qol")` at the top of the require chain.

#### e. Plugins with `event = "VimEnter"` or similar
These were lazy-loaded. With vim.pack they'll load at startup. This is fine — the startup impact is negligible for most plugins.

### Step 5: Update `configure.sh`

The deployment script currently copies `plugins/` into `lua/`. With `plugins/init.lua` now being the entry point, we need to ensure the structure is correct:

```sh
#!/bin/sh
rm ~/.config/nvim -rf
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua
cp ~/repos/setup-env/nvim/kickstart.lua ~/.config/nvim/init.lua
cp ~/repos/setup-env/nvim/snippets ~/.config/nvim -r
cp ~/repos/setup-env/nvim/config ~/.config/nvim/lua -r
cp ~/repos/setup-env/nvim/plugins ~/.config/nvim/lua -r
```

This is actually unchanged — the existing script already copies `plugins/` into `lua/`, so `require("plugins")` will find `lua/plugins/init.lua`.

### Step 6: Update `CLAUDE.md`

Update documentation to reflect:
- Plugin manager is now `vim.pack` (built-in, Neovim 0.12+)
- No bootstrap needed
- Plugin specs are centralized in `plugins/init.lua`
- Individual files are plain config modules (no lazy spec wrappers)
- Build hooks use `PackChanged` autocommand

## Migration Checklist

- [ ] Rewrite `kickstart.lua` — remove lazy.nvim bootstrap
- [ ] Create `plugins/init.lua` with all `vim.pack.add()` calls and build hooks
- [ ] Convert `plugins/qol.lua` (catppuccin, todo-comments, mini.nvim)
- [ ] Convert `plugins/lsp.lua`
- [ ] Convert `plugins/autocompletion.lua`
- [ ] Convert `plugins/autoformat.lua`
- [ ] Convert `plugins/treesitter.lua`
- [ ] Convert `plugins/picker.lua`
- [ ] Convert `plugins/display.lua`
- [ ] Convert `plugins/whichkey.lua`
- [ ] Convert `plugins/obsidian.lua`
- [ ] Convert `plugins/trouble.lua`
- [ ] Convert `plugins/aerial.lua`
- [ ] Convert `plugins/terminal.lua`
- [ ] Convert `plugins/yazi.lua`
- [ ] Convert `plugins/vimtex.lua`
- [ ] Convert `plugins/markdown-utils.lua`
- [ ] Convert `plugins/papis.lua`
- [ ] Convert `plugins/dashboard.lua`
- [ ] Convert `plugins/lazy-dev.lua`
- [ ] Convert `plugins/utils.lua`
- [ ] Update `CLAUDE.md`
- [ ] Verify `configure.sh` still works correctly

## Risks & Considerations

1. **Neovim version**: Requires Neovim 0.12+. If you're on an older version, this won't work.
2. **No lazy loading**: All plugins load at startup. For ~40 plugins this is typically fine (<100ms impact), but if startup time matters, `mini.deps` `now()`/`later()` can be used as a lightweight alternative.
3. **No automatic dependency resolution**: Dependencies must be listed explicitly in `vim.pack.add()` and config files must be required in the right order.
4. **First run**: On first launch after migration, `vim.pack.add()` will clone all plugins. This requires internet and takes a few minutes.
5. **Lockfile**: `vim.pack` creates `nvim-pack-lock.json` in `$XDG_CONFIG_HOME/nvim/`. Consider adding it to version control for reproducibility.
