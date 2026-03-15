require("yazi").setup({
	open_for_directories = false,
	keymaps = {
		show_help = "?",
	},
})
vim.keymap.set({ "n", "v" }, "<leader>y", "<cmd>Yazi cwd<cr>", { desc = "Open [Y]azi" })
-- vim: ts=2 sts=2 sw=2 et
