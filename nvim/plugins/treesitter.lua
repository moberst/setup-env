return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		install_dir = vim.fn.stdpath("data") .. "/site",
	},
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
		require("nvim-treesitter").install({
			"bash",
			"diff",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"vim",
			"vimdoc",
			"yaml",
		})
	end,
}
