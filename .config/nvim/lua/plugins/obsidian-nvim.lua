return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/obsidian-vaults/personal",
			},
		},
		ui = {
			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				["-"] = { char = "x", hl_group = "ObsidianDone" },
			},
		},
		daily_notes = {
			folder = "Daily notes",
			alias_format = "%Y-%m-%d %a",
		},
		---@param spec { id: string, dir: obsidian.Path, title: string|? }
		---@return string|obsidian.Path The full path to the new note.
		note_path_func = function(spec)
			if string.len(spec.title) == 0 then
				local path = spec.dir / tostring(spec.id)
				return path:with_suffix(".md")
			end

			local path = spec.dir / spec.title
			return path:with_suffix(".md")
		end,
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			-- vim.fn.jobstart({ "open", url }) -- Mac OS
			vim.fn.jobstart({ "xdg-open", url }) -- linux
		end,
	},
}
