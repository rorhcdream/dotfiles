return {
	"creativenull/efmls-configs-nvim",
	version = "v1.x.x", -- version is optional, but recommended
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
	},
	-- https://github.com/creativenull/efmls-configs-nvim?tab=readme-ov-file#setup
	config = function()
		local languages = {
			lua = {
				require("efmls-configs.formatters.stylua"),
			},
			go = {
				require("efmls-configs.formatters.gofmt"),
			},
			cpp = {
				require("efmls-configs.formatters.clang_format"),
			},
		}

		local efmls_config = {
			filetypes = vim.tbl_keys(languages),
			settings = {
				rootMarkers = { ".git/" },
				languages = languages,
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
		}

		require("lspconfig").efm.setup(efmls_config)

		-- set autoformat
		-- https://github.com/creativenull/efmls-configs-nvim?tab=readme-ov-file#format-on-save
		local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = lsp_fmt_group,
			callback = function(ev)
				local efm = vim.lsp.get_active_clients({ name = "efm", bufnr = ev.buf })

				if vim.tbl_isempty(efm) then
					return
				end

				vim.lsp.buf.format({ name = "efm" })
			end,
		})
	end,
}
