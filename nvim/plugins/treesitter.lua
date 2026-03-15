require("nvim-treesitter.configs").setup({
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
		"yaml",
	},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
		disable = { "markdown", "vimwiki" },
	},
	indent = { enable = true, disable = { "ruby" } },
})
-- vim: ts=2 sts=2 sw=2 et
