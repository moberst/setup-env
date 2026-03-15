require("conform").setup({
	log_level = vim.log.levels.DEBUG,
	notify_on_error = true,
	default_format_opts = {
		lsp_format = "first",
	},
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		local lsp_format_opt
		if disable_filetypes[vim.bo[bufnr].filetype] then
			lsp_format_opt = "never"
		else
			lsp_format_opt = "first"
		end
		return {
			timeout_ms = 500,
			lsp_format = lsp_format_opt,
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort" },
	},
})
-- vim: ts=2 sts=2 sw=2 et
