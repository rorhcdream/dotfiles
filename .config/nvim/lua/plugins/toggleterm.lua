return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 25,
			open_mapping = "<leader>a",
			terminal_mappings = true,
		})
	end,
}
