require('icon-picker')
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader><Leader>i", "<cmd>PickIcons<cr>", opts)
