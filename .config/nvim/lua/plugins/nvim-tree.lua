return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"antosha417/nvim-lsp-file-operations",
	},
	config = function()
		require("nvim-tree").setup({
			renderer = {
				icons = {
					glyphs = {
						git = {
							unstaged = "M",
							staged = "S",
							unmerged = "U",
							renamed = "R",
							untracked = "N",
							deleted = "D",
							ignored = "I",
						},
					},
				},
			},
			filters = {
				git_ignored = false,
			},
		})

		-- Auto close
		vim.api.nvim_create_autocmd("BufEnter", {
			nested = true,
			callback = function()
				if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
					vim.cmd("b #")
					vim.cmd("quit")
				end
			end,
		})

		-- To avoid conflict with auto-session
		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			pattern = "NvimTree*",
			callback = function()
				local api = require("nvim-tree.api")
				local view = require("nvim-tree.view")

				if not view.is_visible() then
					api.tree.open()
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>e",
			function()
				local nvimTree = require("nvim-tree.api")
				local currentBuf = vim.api.nvim_get_current_buf()
				local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
				if currentBufFt == "NvimTree" then
					nvimTree.tree.toggle()
				else
					nvimTree.tree.find_file({ open = true, focus = true })
				end
			end,
			desc = "focus or toggle file tree",
		},
	},
}
