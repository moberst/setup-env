require("snacks").setup({
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{
					icon = "󰧮 ",
					key = "w",
					desc = "Research Log",
					action = "<cmd>Obsidian today<CR>",
				},
				{
					icon = "󰧮 ",
					desc = "Reflection Log",
					key = "r",
					action = "<cmd>3VimwikiMakeDiaryNote<CR>",
				},
				{
					icon = " ",
					key = "f",
					desc = "Find File",
					action = ":lua Snacks.dashboard.pick('files')",
				},
				{
					icon = " ",
					key = "o",
					desc = "Old Files",
					action = ":lua Snacks.dashboard.pick('oldfiles')",
				},
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
	},
})

vim.keymap.set("n", "<leader>g", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
-- vim: ts=2 sts=2 sw=2 et
