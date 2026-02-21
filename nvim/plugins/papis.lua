return {
	{
		"jghauser/papis.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
			"MunifTanjim/nui.nvim",
			"pysan3/pathlib.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-telescope/telescope.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			require("papis").setup({
				["search"] = {
					results_format = {
						{ "ref", "%s ", "PapisResultsRef" },
						{ "notes", { fallback = { "󰆈 ", "N " } }, "PapisResultsNotes", "force_space" },
						{ "title", "%s", "PapisResultsTitle" },
					},
				},
				enable_keymaps = true,
				enable_fs_watcher = true,
				init_filetypes = { "markdown", "yaml", "tex" },
				cite_formats_fallback = "plain",
				cite_formats = {
					tex = {
						start_str = [[\citep{]],
						end_str = "}",
						separator_str = ", ",
					},
					markdown = {
						start_str = "[[",
						end_str = "]]",
						ref_prefix = "",
						separator_str = "]], [[",
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
			vim.api.nvim_set_hl(0, "PapisResultsNotes", { fg = "#f5a97f" })
		end,
	},
}
