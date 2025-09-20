return {
	'stevearc/conform.nvim',
	config = function()
		require('conform').setup {
			formatters_by_ft = {
				javascript = { 'eslint_d' },
				typescript = { 'prettierd' },
				sh = { 'shfmt' },
				python = { 'ruff_fix', 'ruff_format' },
				json = { 'prettierd' },
				yaml = { 'prettierd' },
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		}
	end
}
