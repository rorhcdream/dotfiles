return {
	"creativenull/efmls-configs-nvim",
	version = "v1.x.x", -- version is optional, but recommended
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	-- https://github.com/creativenull/efmls-configs-nvim?tab=readme-ov-file#setup
	config = function()
		local languages = {
			python = {
				require('efmls-configs.formatters.black'),
				require('efmls-configs.formatters.isort'),
			},
			yaml = {
				require('efmls-configs.linters.yamllint'),
				require('efmls-configs.formatters.prettier'),
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
	end,
}
