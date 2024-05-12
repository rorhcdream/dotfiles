return {
	"ray-x/lsp_signature.nvim",
	-- event = "VeryLazy", -- Does not work in some cases with lazy loading
	config = function()
		require("lsp_signature").setup({
			hint_prefix = "",
		})
	end,
}
