return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		local disableFunc = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end

		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"html",
				"go",
				"python",
				"rust",
				"proto",
				"json",
				"toml",
				"yaml",
			},
			sync_install = false,
			highlight = {
				enable = true,
				disable = disableFunc,
			},
			indent = {
				enable = true,
				disable = disableFunc,
			},
		})
	end,
}
