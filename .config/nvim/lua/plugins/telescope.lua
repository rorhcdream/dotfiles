return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local builtin = require("telescope.builtin")

		local show_ignored = false
		local function toggle_ignored()
			show_ignored = not show_ignored
			local prompt = action_state.get_current_picker(vim.api.nvim_get_current_buf())
			local current_input = prompt:_get_prompt()
			local cmd = { "fd", "--type", "f", "--hidden", "--follow" }
			if show_ignored then cmd[#cmd + 1] = "--no-ignore" end
			builtin.find_files({
				find_command = cmd,
				prompt_title = show_ignored and "Find Files (incl. ignored)" or "Find Files",
				default_text = current_input,
			})
		end

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-u>"] = actions.results_scrolling_up,
						["<C-d>"] = actions.results_scrolling_down,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-a>"] = actions.toggle_all,
						["<ESC>"] = actions.close,
					},
				},
				file_ignore_patterns = {
					"^%.git/objects",
					"^%.git/logs",
					"^%.git/refs",
					"%.cache$",
					"%.o$",
					"%.a$",
					"%.out$",
					"%.class$",
					"%.pdf$",
					"%.mkv$",
					"%.mp4$",
					"%.zip$",
					"^node_modules/",
				},
				vimgrep_arguments = {
					'rg',
					'--follow',
					'--hidden',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--hidden", "--follow" },
					mappings = {
						i = {
							["<C-h>"] = toggle_ignored,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")

		vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Fuzzy find files in CWD" })
		vim.keymap.set("n", "<leader>f", builtin.live_grep, { desc = "Find string in CWD" })

		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "Green" })
	end,
}
