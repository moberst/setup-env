require('bufferline').setup {
  offsets = {
    {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left"
    }
  },
}

require("catppuccin").setup({
  transparent_background = true,
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
    bufferline = true,
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
    lualine_c = {require('auto-session-library').current_session_name},
    lualine_x = {'filename'},
    lualine_y = {'fileformat', 'filetype'},
    lualine_z = {'location'}
  },
}

require("diffview").setup()
require("trouble").setup()
require("fidget").setup()
require("colorizer").setup()
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
    after = "fg", -- "fg" or "bg" or empty
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

local Hydra = require('hydra')
Hydra({
	name = "Resize Window",
	mode = { "n" },
	body = "<C-w>",
	config = {},
	heads = {
		-- resizing window
		{ "<", "<C-w>3<" },
		{ ">", "<C-w>3>" },
		{ "+", "<C-w>2+" },
		{ "-", "<C-w>2-" },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ ";", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

require('which-key').setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
})
