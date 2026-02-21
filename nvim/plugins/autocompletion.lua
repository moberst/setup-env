-- LuaSnip and blink.cmp
return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		init = function()
			vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()]])
		end,
		config = function()
			local ls = require("luasnip")
			ls.setup({
				enable_autosnippets = true,
				store_selection_keys = "<C-j>",
				update_events = { "TextChanged", "TextChangedI" },
			})
			require("luasnip.loaders.from_lua").load({ paths = "~/repos/setup-env/nvim/snippets" })

			vim.keymap.set({ "i" }, "<C-y>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				ls.jump(-1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	{ -- Autocompletion
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"moberst/vim-snippets",
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "luasnip" },
			keymap = {
				preset = "default",
				["<C-y>"] = { "select_and_accept" },
				["<C-e>"] = { "cancel" },
				["<C-space>"] = { "show" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = {
				documentation = { auto_show = true },
			},
			sources = {
				default = { "lazydev", "lsp", "snippets", "path", "buffer" },
				per_filetype = {
					markdown = { "snippets", "lsp", "path", "buffer", "papis", "render-markdown" },
					vimwiki = { "snippets", "lsp", "path", "buffer", "papis" },
					yaml = { "snippets", "lsp", "path", "buffer", "papis" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
						["render-markdown"] = {
						name = "RenderMarkdown",
						module = "render-markdown.integ.blink",
					},
				},
			},
			cmdline = {
				enabled = true,
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
