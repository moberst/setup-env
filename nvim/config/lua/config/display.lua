local home = os.getenv('HOME')
local db = require('dashboard')

db.setup({
  theme = 'hyper',
  config = {
    shortcut = {
      {
        desc= '󰧮 New File',
        key = 'e',
        action ='enew'
      },
      {
        desc= '󰧮 Research Log',
        key = 'w',
        action ='1VimwikiMakeDiaryNote'
      },
      {
        desc= '󰧮 Research Tags',
        key = 't',
        action = "cd /home/moberst/Dropbox/research/wiki | lua require'telescope.builtin'.tags({ctags_file = '/home/moberst/Dropbox/research/wiki/.vimwiki_tags'})"
      },
      {
        desc= '󰧮 Reflection Log',
        key = 'r',
        action ='2VimwikiMakeDiaryNote'
      },
      {
        desc= '󰧮 Projects',
        key = 'p',
        action ="lua require'nvim-possession'.list()"
      },
      {
        desc= 'Quit',
        key = 'q',
        action ='q'
      },
    },
    project = {
      limit = 0
    },
    mru = {
      limit = 5
    }
  }
})

-- require('bufferline').setup {
--   options = {
--     offsets = {
--       {
--         filetype = "NvimTree",
--         text = "File Explorer",
--         highlight = "Directory",
--         text_align = "left"
--       }
--     },
--   }
-- }

require("catppuccin").setup({
  transparent_background = false,
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = {"italic"},
        hints = {"italic"},
        warnings = {"italic"},
        information = {"italic"},
      },
      underlines = {
        errors = {"underline"},
        hints = {"underline"},
        warnings = {"underline"},
        information = {"underline"},
      },
    },
    cmp = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
      transparent_panel = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    -- bufferline = true,
    notify = true,
    vimwiki = true,
    markdown = true,
    leap = true,
    ts_rainbow = true,
  },
})

require('lualine').setup {
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {
      {
        "require('nvim-possession').status()",
        cond = function()
            return require("nvim-possession").status ~= nil
        end,
      },
    },
    lualine_y = {'fileformat', 'filetype'},
    lualine_z = {'location'}
  },
}

require("diffview").setup()
--require("colorizer").setup()
require("todo-comments").setup({
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of hilight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})

require("twilight").setup()

require('which-key').setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
})

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

require("notify").setup({
  timeout = 1000,
  topdown = false,
})
