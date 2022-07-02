require("neotest").setup({
  adapters = {
    require("neotest-python")
  },
})
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>tt", ":lua require('neotest').summary.toggle()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>tr", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>to", ":lua require('neotest').output.open({enter = true})<CR>", opts)


