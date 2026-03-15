require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 20
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	start_in_insert = false,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	direction = "horizontal",
	on_open = function(term)
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	end,
	close_on_exit = true,
	shade_terminals = true,
})
-- vim: ts=2 sts=2 sw=2 et
