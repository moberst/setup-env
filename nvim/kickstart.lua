-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.inccommand = "split"
-- Mine
vim.cmd([[set guicursor=]])
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.linebreak = true
-- Keep visual mode after indent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "<BS>", "<nop>")
vim.keymap.set("n", "q:", "<nop>")
vim.cmd([[:command W w]])
vim.cmd([[:command Xa xa]])
vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/nvim/bin/python3")

-- Enable break indent
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>ql", function()
	local win = vim.api.nvim_get_current_win()
	local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
	local action = qf_winid > 0 and "lclose" or "lopen"
	vim.cmd(action)
end, { desc = "Toggle loclist", noremap = true, silent = true })

vim.keymap.set("n", "<leader>qq", function()
	local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
	local action = qf_winid > 0 and "cclose" or "copen"
	vim.cmd("botright " .. action)
end, { desc = "Toggle quickfix", noremap = true, silent = true })

vim.diagnostic.config({
	float = true,
	jump = {
		float = false,
		wrap = true,
	},
	severity_sort = false,
	signs = {
		text = { "", "", "", "" },
	},
	underline = true,
	update_in_insert = false,
	virtual_lines = false,
	virtual_text = true,
})
vim.keymap.set("n", "<leader>tl", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "[T]oggle diagnostic [l]ines" })

vim.cmd([[
au BufNewFile,BufRead *.tex
    \ set spell |
    \ set spellfile=$HOME/Dropbox/org/tex/en.utf-8.add |
    \ set colorcolumn=0
]])

vim.cmd([[
au BufNewFile,BufRead *.md
    \ set spell |
    \ set spellfile=$HOME/Dropbox/org/md/en.utf-8.add |
]])

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	spec = { { import = "plugins" } },
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
