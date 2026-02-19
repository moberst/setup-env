-- LuaSnip and nvim-cmp
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			-- "SirVer/ultisnips",
			-- "quangnguyen30192/cmp-nvim-ultisnips",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"moberst/vim-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- { name = "ultisnips" },
					{ name = "path" },
				},
			})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
			cmp.setup.filetype("markdown", {
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "omni" },
					{ name = "papis" },
					{ name = "render-markdown" },
				}),
			})
			cmp.setup.filetype("vimwiki", {
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "omni" },
					{ name = "papis" },
				}),
			})
			cmp.setup.filetype("yaml", {
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "omni" },
					{ name = "papis" },
				}),
			})
		end,
	},
}
