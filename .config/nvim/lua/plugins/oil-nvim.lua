return {
	'stevearc/oil.nvim',
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")
		oil.setup({
			default_file_explorer = false,
			delete_to_trash = true,
			keymaps = {
				["<ESC>"] = "actions.close",
				["q"] = "actions.close",
			},
			view_options = {
				show_hidden = true,
			},
		})

		local open_oil = function()
			local filetype = vim.api.nvim_buf_get_option(0, "filetype")
			if filetype == 'NvimTree' then
				local nvim_tree_api = require("nvim-tree.api")
				local parent_node = nvim_tree_api.tree.get_node_under_cursor().parent
				oil.open_float(parent_node.absolute_path)
			else
				oil.open_float()
			end
		end

		vim.keymap.set("n", "<leader>o", open_oil, { silent = true })
	end
}
