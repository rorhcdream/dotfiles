return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup(
			{
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
				extensions = {
					'fugitive',
					'lazy',
					'mason',
					'nvim-tree',
					'oil',
					'toggleterm',
				},
			}
		)
	end,
	enabled = true,
}
