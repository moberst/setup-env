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
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
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
    lualine_c = {"%{fnamemodify(v:this_session,':t')}"},
    lualine_x = {'filename'},
    lualine_y = {'fileformat', 'filetype'},
    lualine_z = {'location'}
  },
}

require("diffview").setup()
require("trouble").setup()
require("fidget").setup()
require("colorizer").setup()
require("todo-comments").setup()

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

require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    -- "BufferLineTabClose",
    -- "BufferlineBufferSelected",
    -- "BufferLineFill",
    -- "BufferLineBackground",
    -- "BufferLineSeparator",
    -- "BufferLineIndicatorSelected",
  },
  exclude = {}, -- table: groups you don't want to clear
})
