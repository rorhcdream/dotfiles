return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✔",
					package_pending = "➜",
					package_uninstalled = "x",
				},
			},
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		})
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"efm",
			},
			automatic_installation = false,
		})
	end,
}
