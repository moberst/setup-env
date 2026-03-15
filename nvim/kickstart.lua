require("config.options")
require("config.keymaps")
require("config.spelling")
vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/nvim/bin/python3")

-- Load all plugins via vim.pack and configure them
require("plugins")
-- vim: ts=2 sts=2 sw=2 et
