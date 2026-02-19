return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"plasticboy/vim-markdown",
		branch = "master",
		require = { "godlygeek/tabular" },
		config = function()
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_auto_insert_bullets = 0
			vim.g.tex_conceal = ""
		end,
	},
}
