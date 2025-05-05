return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 25,
			open_mapping = "<leader><Tab>",
			terminal_mappings = true,
		})
	end,
}
