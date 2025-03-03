-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
-- Mine
vim.cmd([[set guicursor=]])
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.linebreak = true
-- Keep visual mode after indent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "<BS>", "<nop>")
vim.keymap.set("n", "q:", "<nop>")
vim.cmd([[:command W w]])
vim.cmd([[:command Xa xa]])
vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/nvim/bin/python3")
-- Used for making render-markdown work in vimwiki
vim.treesitter.language.register('markdown', 'vimwiki')

-- Enable break indent
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>ql", function()
  local win = vim.api.nvim_get_current_win()
  local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  local action = qf_winid > 0 and "lclose" or "lopen"
  vim.cmd(action)
end, { desc = "Toggle loclist", noremap = true, silent = true })

vim.keymap.set("n", "<leader>qq", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { desc = "Toggle quickfix", noremap = true, silent = true })

vim.diagnostic.config({
  float = true,
  jump = {
    float = false,
    wrap = true,
  },
  severity_sort = false,
  signs = {
    text = { "", "", "", "" },
  },
  underline = true,
  update_in_insert = false,
  virtual_lines = false,
  virtual_text = true,
})
vim.keymap.set("n", "<leader>tl", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "[T]oggle diagnostic [l]ines" })

vim.cmd([[
function! VimwikiLinkHandler(link)
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'edit ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction
]])

vim.cmd([[
au BufNewFile,BufRead *.tex
    \ set spell |
    \ set spellfile=$HOME/Dropbox/org/tex/en.utf-8.add |
    \ set colorcolumn=0
]])

vim.filetype.add({
  extension = {
    wiki = "vimwiki",
  },
  pattern = {
    ["*.wiki"] = "vimwiki",
  },
})

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "jghauser/papis.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "MunifTanjim/nui.nvim",
      "pysan3/pathlib.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("papis").setup({
        enable_keymaps = true,
        enable_fs_watcher = true,
        init_filetypes = { "markdown", "yaml", "vimwiki", "tex" },
        enable_modules = {
          ["search"] = true,     -- Enables/disables the search module
          ["completion"] = true, -- Enables/disables the completion module
          ["at-cursor"] = true,  -- Enables/disables the at-cursor module
          ["formatter"] = true,  -- Enables/disables the formatter module
          ["colors"] = true,     -- Enables/disables default highlight groups (you
          -- probably want this)
          ["base"] = true,       -- Enables/disables the base module (you definitely
          -- want this)
          ["debug"] = true,      -- Enables/disables the debug module (useful to
          -- troubleshoot and diagnose issues)
        },
        cite_formats = {
          tex = {
            start_str = [[\citep{]],
            end_str = "}",
            separator_str = ", ",
          },
          vimwiki = {
            ref_prefix = "[[",
            end_str = "]]",
          },
          markdown = {
            ref_prefix = "[[",
            end_str = "]]",
          },
          rmd = {
            ref_prefix = "@",
            separator_str = "; ",
          },
          plain = {
            separator_str = ", ",
          },
          org = {
            start_str = "[cite:",
            end_str = "]",
            ref_prefix = "@",
            separator_str = ";",
          },
          norg = {
            start_str = "{= ",
            end_str = "}",
            separator_str = "; ",
          },
          typst = {
            ref_prefix = "@",
            separator_str = " ",
          },
        },
      })
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>", { desc = "[T]oggle [A]erial" })
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "tpope/vim-unimpaired",  lazy = false },
  { "kevinhwang91/nvim-bqf", lazy = false },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_toc_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_toc_config = { mode = 1, layers = { "content" }, tocdepth = 2 }

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_compiler_latexmk = { out_dir = "./tex", aux_dir = "./tex" }

      vim.g.vimtex_mappings_enabled = false
      local augroup = vim.api.nvim_create_augroup("vimtexConfig", {})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        group = augroup,
        callback = function(event)
          local wk = require("which-key")
          wk.add({
            buffer = event.buf,
            {
              "<localleader>l",
              group = "VimTeX",
              icon = { icon = "", color = "green" },
              mode = "nx",
            },
            {
              mode = "n",
              {
                "<localleader>ll",
                "<plug>(vimtex-compile)",
                desc = "Compile",
                icon = { icon = "", color = "green" },
              },
              {
                "<localleader>lL",
                "<plug>(vimtex-compile-selected)",
                desc = "Compile selected",
                icon = { icon = "", color = "green" },
                mode = "nx",
              },
              {
                "<localleader>li",
                "<plug>(vimtex-info)",
                desc = "Information",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lI",
                "<plug>(vimtex-info-full)",
                desc = "Full information",
                icon = { icon = "󰙎", color = "purple" },
              },
              {
                "<localleader>lt",
                "<plug>(vimtex-toc-open)",
                desc = "Table of Contents",
                icon = { icon = "󰠶", color = "purple" },
              },
              {
                "<localleader>lT",
                "<plug>(vimtex-toc-toggle)",
                desc = "Toggle table of Contents",
                icon = { icon = "󰠶", color = "purple" },
              },
              {
                "<localleader>lq",
                "<plug>(vimtex-log)",
                desc = "Log",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lv",
                "<plug>(vimtex-view)",
                desc = "View",
                icon = { icon = "", color = "green" },
              },
              {
                "<localleader>lr",
                "<plug>(vimtex-reverse-search)",
                desc = "Reverse search",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lk",
                "<plug>(vimtex-stop)",
                desc = "Stop",
                icon = { icon = "", color = "red" },
              },
              {
                "<localleader>lK",
                "<plug>(vimtex-stop-all)",
                desc = "Stop all",
                icon = { icon = "󰓛", color = "red" },
              },
              {
                "<localleader>le",
                "<plug>(vimtex-errors)",
                desc = "Errors",
                icon = { icon = "", color = "red" },
              },
              {
                "<localleader>lo",
                "<plug>(vimtex-compile-output)",
                desc = "Compile output",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lg",
                "<plug>(vimtex-status)",
                desc = "Status",
                icon = { icon = "󱖫", color = "purple" },
              },
              {
                "<localleader>lG",
                "<plug>(vimtex-status-full)",
                desc = "Full status",
                icon = { icon = "󱖫", color = "purple" },
              },
              {
                "<localleader>lc",
                "<plug>(vimtex-clean)",
                desc = "Clean",
                icon = { icon = "󰃢", color = "orange" },
              },
              {
                "<localleader>lh",
                "<Cmd>VimtexClearCache ALL<cr>",
                desc = "Clear all cache",
                icon = { icon = "󰃢", color = "grey" },
              },
              {
                "<localleader>lC",
                "<plug>(vimtex-clean-full)",
                desc = "Full clean",
                icon = { icon = "󰃢", color = "red" },
              },
              {
                "<localleader>lx",
                "<plug>(vimtex-reload)",
                desc = "Reload",
                icon = { icon = "󰑓", color = "green" },
              },
              {
                "<localleader>lX",
                "<plug>(vimtex-reload-state)",
                desc = "Reload state",
                icon = { icon = "󰑓", color = "cyan" },
              },
              {
                "<localleader>lm",
                "<plug>(vimtex-imaps-list)",
                desc = "Input mappings",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>ls",
                "<plug>(vimtex-toggle-main)",
                desc = "Toggle main",
                icon = { icon = "󱪚", color = "green" },
              },
              {
                "<localleader>la",
                "<plug>(vimtex-context-menu)",
                desc = "Context menu",
                icon = { icon = "󰮫", color = "purple" },
              },
              {
                "ds",
                group = "+surrounding",
                icon = { icon = "󰗅", color = "green" },
              },
              {
                "dse",
                "<plug>(vimtex-env-delete)",
                desc = "environment",
                icon = { icon = "", color = "red" },
              },
              {
                "dsc",
                "<plug>(vimtex-cmd-delete)",
                desc = "command",
                icon = { icon = "", color = "red" },
              },
              {
                "ds$",
                "<plug>(vimtex-env-delete-math)",
                desc = "math",
                icon = { icon = "󰿈", color = "red" },
              },
              {
                "dsd",
                "<plug>(vimtex-delim-delete)",
                desc = "delimeter",
                icon = { icon = "󰅩", color = "red" },
              },
              {
                "cs",
                group = "+surrounding",
                icon = { icon = "󰗅", color = "green" },
              },
              {
                "cse",
                "<plug>(vimtex-env-change)",
                desc = "environment",
                icon = { icon = "", color = "blue" },
              },
              {
                "csc",
                "<plug>(vimtex-cmd-change)",
                desc = "command",
                icon = { icon = "", color = "blue" },
              },
              {
                "cs$",
                "<plug>(vimtex-env-change-math)",
                desc = "math environment",
                icon = { icon = "󰿈", color = "blue" },
              },
              {
                "csd",
                "<plug>(vimtex-delim-change-math)",
                desc = "delimeter",
                icon = { icon = "󰅩", color = "blue" },
              },
              {
                "ts",
                group = "+surrounding",
                icon = { icon = "󰗅", color = "green" },
                mode = "nx",
              },
              {
                "tsf",
                "<plug>(vimtex-cmd-toggle-frac)",
                desc = "fraction",
                icon = { icon = "󱦒", color = "yellow" },
                mode = "nx",
              },
              {
                "tsc",
                "<plug>(vimtex-cmd-toggle-star)",
                desc = "command",
                icon = { icon = "", color = "yellow" },
              },
              {
                "tse",
                "<plug>(vimtex-env-toggle-star)",
                desc = "environment",
                icon = { icon = "", color = "yellow" },
              },
              {
                "ts$",
                "<plug>(vimtex-env-toggle-math)",
                desc = "math environment",
                icon = { icon = "󰿈", color = "yellow" },
              },
              {
                "tsb",
                "<plug>(vimtex-env-toggle-break)",
                desc = "break",
                icon = { icon = "󰿈", color = "yellow" },
              },
              {
                "<F6>",
                "<plug>(vimtex-env-surround-line)",
                desc = "Surround line with environment",
                icon = { icon = "", color = "purple" },
              },
              {
                "<F6>",
                "<plug>(vimtex-env-surround-visual)",
                desc = "Surround selection with environment",
                icon = { icon = "", color = "purple" },
                mode = "x",
              },
              {
                "tsd",
                "<plug>(vimtex-delim-toggle-modifier)",
                desc = "delimeter",
                icon = { icon = "󰅩", color = "yellow" },
                mode = "nx",
              },
              {
                "tsD",
                "<plug>(vimtex-delim-toggle-modifier-reverse)",
                desc = "revers surrounding delimeter",
                icon = { icon = "󰅩", color = "yellow" },
                mode = "nx",
              },
              {
                "<F7>",
                "<plug>(vimtex-cmd-create)",
                desc = "Create command",
                icon = { icon = "󰅩", color = "green" },
                mode = "nxi",
              },
              {
                "]]",
                "<plug>(vimtex-delim-close)",
                desc = "Close delimeter",
                icon = { icon = "󰅩", color = "green" },
                mode = "i",
              },
              {
                "<F8>",
                "<plug>(vimtex-delim-add-modifiers)",
                desc = "Add \\left and \\right",
                icon = { icon = "󰅩", color = "green" },
                mode = "n",
              },
            },
            {
              mode = "xo",
              {
                "ac",
                "<plug>(vimtex-ac)",
                desc = "command",
                icon = { icon = "", color = "orange" },
              },
              {
                "ic",
                "<plug>(vimtex-ic)",
                desc = "command",
                icon = { icon = "", color = "orange" },
              },
              {
                "ad",
                "<plug>(vimtex-ad)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "orange" },
              },
              {
                "id",
                "<plug>(vimtex-id)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "orange" },
              },
              {
                "ae",
                "<plug>(vimtex-ae)",
                desc = "environment",
                icon = { icon = "", color = "orange" },
              },
              {
                "ie",
                "<plug>(vimtex-ie)",
                desc = "environment",
                icon = { icon = "", color = "orange" },
              },
              {
                "a$",
                "<plug>(vimtex-a$)",
                desc = "math",
                icon = { icon = "󰿈", color = "orange" },
              },
              {
                "i$",
                "<plug>(vimtex-i$)",
                desc = "math",
                icon = { icon = "󰿈", color = "orange" },
              },
              {
                "aP",
                "<plug>(vimtex-aP)",
                desc = "section",
                icon = { icon = "󰚟", color = "orange" },
              },
              {
                "iP",
                "<plug>(vimtex-iP)",
                desc = "section",
                icon = { icon = "󰚟", color = "orange" },
              },
              {
                "am",
                "<plug>(vimtex-am)",
                desc = "item",
                icon = { icon = "", color = "orange" },
              },
              {
                "im",
                "<plug>(vimtex-im)",
                desc = "item",
                icon = { icon = "", color = "orange" },
              },
            },
            {
              mode = "nxo",
              {
                "%",
                "<plug>(vimtex-%)",
                desc = "Matching pair",
                icon = { icon = "󰐱", color = "cyan" },
              },
              {
                "]]",
                "<plug>(vimtex-]])",
                desc = "Next end of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "][",
                "<plug>(vimtex-][)",
                desc = "Next beginning of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "[]",
                "<plug>(vimtex-[])",
                desc = "Previous end of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "[[",
                "<plug>(vimtex-[[)",
                desc = "Previous beginning of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "]m",
                "<plug>(vimtex-]m)",
                desc = "Next start of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "]M",
                "<plug>(vimtex-]M)",
                desc = "Next end of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[m",
                "<plug>(vimtex-[m)",
                desc = "Previous start of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[M",
                "<plug>(vimtex-[M)",
                desc = "Previous end of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "]n",
                "<plug>(vimtex-]n)",
                desc = "Next start of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "]N",
                "<plug>(vimtex-]N)",
                desc = "Next end of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "[n",
                "<plug>(vimtex-[n)",
                desc = "Previous start of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "[N",
                "<plug>(vimtex-[N)",
                desc = "Previous end of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "]r",
                "<plug>(vimtex-]r)",
                desc = "Next start of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "]R",
                "<plug>(vimtex-]R)",
                desc = "Next end of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "[r",
                "<plug>(vimtex-[r)",
                desc = "Previous start of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "[R",
                "<plug>(vimtex-[R)",
                desc = "Previous end of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "]/",
                "<plug>(vimtex-]/)",
                desc = "Next start of a comment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "]*",
                "<plug>(vimtex-]star)",
                desc = "Next end of a comment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[/",
                "<plug>(vimtex-[/)",
                desc = "Previous start of a comment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[*",
                "<plug>(vimtex-[star)",
                desc = "Previous end of a comment",
                icon = { icon = "", color = "cyan" },
              },
            },
            {
              "K",
              "<plug>(vimtex-doc-package)",
              desc = "See package documentation",
              icon = { icon = "󱔗", color = "azure" },
            },
            -- see snippet at the top
          })
        end,
      })
    end,
  },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>y",
        mode = { "n", "v" },
        "<cmd>Yazi cwd<cr>",
        desc = "Open [Y]azi",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "?",
      },
    },
  },
  {
    -- "moberst/avante.nvim",
    -- branch = "dev",
    dir = "~/repos/avante.nvim",
    dev = true,
    event = "VeryLazy",
    priority = 0,
    lazy = false,
    config = function()
      require("avante_lib").load()
      require("avante").setup({
        provider = "claude",
        -- See https://github.com/yetone/avante.nvim/pull/1072
        auto_suggestions_provider = "claude",
        -- add any opts here
      })
    end,
    build = "make BUILD_FROM_SOURCE=true",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup({})
        end,
      },
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante", "vimwiki" },
        },
        ft = { "markdown", "Avante", "vimwiki" },
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre /home/moberst/obsidian/main/*.md",
    --   "BufNewFile /home/moberst/obsidian/main/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/obsidian/main",
        },
        {
          name = "main",
          path = "~/Dropbox/papis",
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "diary",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-plan" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "daily.md"
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      ui = {
        enable = false
      },
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>wo"] = {
          action = "<Cmd>ObsidianOpen<CR>",
          opts = { buffer = true },
          desc = "[W]iki [O]pen in Obsidian"
        },
        ["<leader>ws"] = {
          action = "<Cmd>ObsidianQuickSwitch<CR>",
          opts = { buffer = true },
          desc = "[W]iki [S]earch"
        },
        ["<leader>wt"] = {
          action = "<Cmd>ObsidianTags<CR>",
          opts = { buffer = true },
          desc = "[W]iki [T]ags"
        },
        ["<leader>wb"] = {
          action = "<Cmd>ObsidianBackLinks<CR>",
          opts = { buffer = true },
          desc = "[W]iki [B]acklinks"
        },
        ["<leader>wrn"] = {
          action = "<Cmd>ObsidianRename<CR>",
          opts = { buffer = true },
          desc = "[W]iki [R]ename"
        },
        ["<leader>wnf"] = {
          action = "<Cmd>ObsidianNew<CR>",
          opts = { buffer = true },
          desc = "[W]iki [N]ew [F]resh"
        },
        ["<leader>wit"] = {
          action = "<Cmd>ObsidianTemplate<CR>",
          opts = { buffer = true },
          desc = "[W]iki [I]nsert [T]emplate"
        },
        ["<leader>wnt"] = {
          action = "<Cmd>ObsidianNewFromTemplate<CR>",
          opts = { buffer = true },
          desc = "[W]iki [N]ew [T]emplate"
        },
        ["<leader>wc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
          desc = "[W]iki Toggle [C]heckbox"
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },
    }
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_list = {
        {
          name = "Obsidian",
          path = "~/obsidian/main",
          syntax = "markdown",
          ext = ".md",
        },
        {
          name = "Research",
          path = "~/Dropbox/research/wiki",
          syntax = "default",
          ext = ".wiki",
          links_space_char = "-",
          auto_tags = 1,
        },
        {
          name = "Reflection",
          path = "~/log/wiki",
          syntax = "default",
          ext = ".wiki",
          links_space_char = "-",
          auto_tags = 1,
        },
      }
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_auto_chdir = 1
      vim.g.vimwiki_folding = "expr"
      vim.keymap.set("n", "<leader>ww", "<Plug>VimwikiMakeDiaryNote")
      -- vim.keymap.set("n", "<leader>wt", "<Cmd>VimwikiGenerateTagLinks<CR>")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "aerial" },
        lualine_y = { "fileformat", "filetype" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1001,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = "󰧮 ",
              key = "w",
              desc = "Research Log",
              action = "<cmd>1VimwikiMakeDiaryNote<CR>",
            },
            {
              icon = "󰧮 ",
              desc = "Reflection Log",
              key = "r",
              action = "<cmd>3VimwikiMakeDiaryNote<CR>",
            },
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = "󰒲 ",
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>g",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      start_in_insert = false,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      on_open = function(term)
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end, -- function to run when the terminal opens
      close_on_exit = true,
      shade_terminals = true,
    },
  },
  { "stevearc/dressing.nvim", opts = {} },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        command_palette = true,
      },
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      { "rcarriga/nvim-notify", opts = { top_down = false } },
    },
  },
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
          map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")

          -- Actions
          map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
          map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
          map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
          map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
          map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
          map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
          map("n", "<leader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
          map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")
          map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")

          -- Text object
          map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
          map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  {                     -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      require("telescope").setup({
        defaults = {
          tiebreak = function()
            return true
          end,
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
        pickers = {
          tags = {
            only_sort_tags = true,
            fname_width = 50,
            -- sorting_strategy = 'ascending',
          },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
            },
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
      vim.keymap.set("n", "<leader>ft", builtin.tags, { desc = "[F]ind [T]ags" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[F]ind [C]ommands" })
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "[F]ind [S]tring" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[F]ind [/] in Open Files" })
    end,
  },

  -- LSP Plugins
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("K", vim.lsp.buf.signature_help, "Signature Help")
          map("[d", vim.diagnostic.goto_prev, "Previous [d]iagnostic")
          map("]d", vim.diagnostic.goto_next, "Next [d]iagnostic")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      if vim.g.have_nerd_font then
        local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config({ signs = { text = diagnostic_signs } })
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        ruff = {
          settings = {
            cmd_env = { RUFF_TRACE = "messages" },
            init_options = {
              logLevel = "debug",
            },
          },
        },
        pylsp = {
          settings = {
            -- See https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
            pylsp = {
              plugins = {
                autopep8 = { enabled = false },
                flake8 = { enabled = false },
                pycodestyle = { enabled = false },
                pydocstyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                yapf = { enabled = false },
              },
            },
          },
        },
      }
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        "ruff",
        "pylsp",
        "texlab",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {},
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "prefer"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        tex = { "latexindent" },
      },
    },
  },

  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "SirVer/ultisnips",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "moberst/vim-snippets",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete({}),
        }),
        sources = {
          {
            name = "lazydev",
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "ultisnips" },
          { name = "path" },
        },
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
      cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
          { name = "ultisnips" },
          { name = "omni" },
          { name = "papis" },
          { name = "render-markdown" },
        }),
      })
      cmp.setup.filetype("vimwiki", {
        sources = cmp.config.sources({
          { name = "ultisnips" },
          { name = "omni" },
          { name = "papis" },
        }),
      })
      cmp.setup.filetype("yaml", {
        sources = cmp.config.sources({
          { name = "ultisnips" },
          { name = "omni" },
          { name = "papis" },
        }),
      })
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = false,
        integrations = {
          aerial = true,
          gitsigns = true,
          markdown = true,
          mason = true,
          mini = { enabled = true },
          noice = true,
          render_markdown = true,
          cmp = true,
          notify = true,
          treesitter = true,
          treesitter_context = true,
          telescope = { enabled = true },
          vimwiki = true,
          fidget = true,
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require("mini.statusline")
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup({ use_icons = vim.g.have_nerd_font })

      require("mini.misc").setup({})
      MiniMisc.setup_auto_root({ ".git", "index.wiki" }, function()
        return vim.fn.expand("%:p:h")
      end)
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      -- 	return "%2l:%-2v"
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
