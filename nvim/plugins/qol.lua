-- Catppuccin colorscheme
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
		blink_cmp = true,
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

-- Todo comments
require("todo-comments").setup({ signs = false })

-- Mini.nvim modules
require("mini.ai").setup({ n_lines = 500 })

require("mini.surround").setup({
	mappings = {
		add = "ys",
		delete = "ds",
		find = "",
		find_left = "",
		highlight = "",
		replace = "cs",
		update_n_lines = "",
		suffix_last = "",
		suffix_next = "",
	},
	search_method = "cover_or_next",
})

-- Remap adding surrounding to Visual mode selection
vim.keymap.del("x", "ys")
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- Make special mapping for "add surrounding for line"
vim.keymap.set("n", "yss", "ys_", { remap = true })

require("mini.misc").setup({})
MiniMisc.setup_auto_root({ ".git", "index.wiki" }, function()
	return vim.fn.expand("%:p:h")
end)
-- vim: ts=2 sts=2 sw=2 et
