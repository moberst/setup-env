vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("K", vim.lsp.buf.signature_help, "Signature Help")
		map("[d", vim.diagnostic.goto_prev, "Previous [d]iagnostic")
		map("]d", vim.diagnostic.goto_next, "Next [d]iagnostic")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup =
				vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({
						group = "kickstart-lsp-highlight",
						buffer = event2.buf,
					})
				end,
			})
		end
	end,
})

-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
	local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
	local diagnostic_signs = {}
	for type, icon in pairs(signs) do
		diagnostic_signs[vim.diagnostic.severity[type]] = icon
	end
	vim.diagnostic.config({ signs = { text = diagnostic_signs } })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
	ruff = {
		settings = {
			cmd_env = { RUFF_TRACE = "messages" },
			init_options = {
				logLevel = "debug",
			},
		},
	},
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					autopep8 = { enabled = false },
					flake8 = { enabled = false },
					pycodestyle = { enabled = false },
					pydocstyle = { enabled = false },
					pyflakes = { enabled = false },
					pylint = { enabled = false },
					yapf = { enabled = false },
				},
			},
		},
	},
}
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua",
	"ruff",
	"pylsp",
})

require("mason").setup({})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
-- vim: ts=2 sts=2 sw=2 et
