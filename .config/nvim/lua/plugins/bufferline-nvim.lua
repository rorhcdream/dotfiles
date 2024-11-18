return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		vim.keymap.set('n', '<leader>b', '<cmd>BufferLinePick<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>d', '<cmd>BufferLinePickClose<CR>', { noremap = true, silent = true })
		require("bufferline").setup(
			{
				options = {
					separator_style = "thin",
					hover = {
						enabled = true,
						delay = 200,
						reveal = { 'close' }
					},
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true -- use a "true" to enable the default, or set your own character
						}
					},
				}
			}
		)
	end
}
