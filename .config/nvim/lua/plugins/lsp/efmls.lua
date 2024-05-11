return {
	"creativenull/efmls-configs-nvim",
	enabled = false, -- language servers already have built-in formatters
	version = "v1.x.x", -- version is optional, but recommended
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
	},
	-- https://github.com/creativenull/efmls-configs-nvim?tab=readme-ov-file#setup
	config = function()
		local languages = {
			---- lua-ls already has a built-in formatter
			-- lua = {
			-- 	require("efmls-configs.formatters.stylua"),
			-- },
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
