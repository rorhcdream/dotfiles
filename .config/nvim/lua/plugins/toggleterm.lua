return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = "<leader>`",
			terminal_mappings = true,
		})
	end,
}
