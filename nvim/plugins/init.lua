-- Plugin management via vim.pack (Neovim 0.12+)
-- All plugins are declared here; individual config modules are required below.

vim.pack.add({
	-- Colorscheme
	"https://github.com/catppuccin/nvim",

	-- Core LSP & completion
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/moberst/vim-snippets",

	-- Formatting & treesitter
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",

	-- Navigation & search
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lua/plenary.nvim",

	-- UI
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/rcarriga/nvim-notify",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",

	-- Editing & QoL
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/tpope/vim-unimpaired",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/kevinhwang91/nvim-bqf",
	"https://github.com/stevearc/dressing.nvim",

	-- LSP extras & diagnostics
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/stevearc/aerial.nvim",

	-- Terminal & file manager
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/mikavilpas/yazi.nvim",

	-- Writing & research
	"https://github.com/obsidian-nvim/obsidian.nvim",
	"https://github.com/jghauser/papis.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/plasticboy/vim-markdown",
	"https://github.com/godlygeek/tabular",
	"https://github.com/lervag/vimtex",

	-- Dashboard
	"https://github.com/folke/snacks.nvim",

	-- Dependencies
	"https://github.com/kkharji/sqlite.lua",
	"https://github.com/pysan3/pathlib.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/sindrets/diffview.nvim",
})

-- Build hooks
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		if name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		elseif name == "telescope-fzf-native.nvim" then
			vim.fn.system({ "make", "-C", ev.data.path })
		elseif name == "LuaSnip" then
			vim.fn.system({ "make", "install_jsregexp", "-C", ev.data.path })
		end
	end,
})

-- Configure plugins in dependency order
require("plugins.qol")
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
-- vim: ts=2 sts=2 sw=2 et
