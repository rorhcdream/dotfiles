return {
	'pwntester/octo.nvim',
	requires = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		require("octo").setup({
			use_local_fs = true,
			mappings = {
				review_thread = {
					select_next_entry = { lhs = "<Tab>", desc = "move to next changed file" },
					select_prev_entry = { lhs = "<S-Tab>", desc = "move to previous changed file" },
				},
				review_diff = {
					select_next_entry = { lhs = "<Tab>", desc = "move to next changed file" },
					select_prev_entry = { lhs = "<S-Tab>", desc = "move to previous changed file" },
				},
			},
		})
	end
}
