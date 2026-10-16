return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	keys = {
		{ "<leader>v",  nil,                      desc = "Diffview" },
		{ "<leader>vo", "<cmd>DiffviewOpen<cr>",  desc = "Review current diff" },
		{ "<leader>vc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
		{
			"<leader>vh",
			function()
				local file = vim.api.nvim_buf_get_name(0)
				local cwd = vim.bo.buftype == "" and file ~= "" and vim.fs.dirname(file) or vim.fn.getcwd()
				local function git(args)
					local result = vim.system(vim.list_extend({ "git", "-C", cwd }, args), { text = true }):wait()
					if result.code == 0 then
						return vim.trim(result.stdout)
					end
				end

				local root = git({ "rev-parse", "--show-toplevel" })
				if not root then
					vim.notify("Branch review: current buffer/cwd is not in a Git repository", vim.log.levels.WARN)
					return
				end

				local bases = { "refs/remotes/origin/main", "refs/remotes/origin/master" }
				local default = git({ "symbolic-ref", "--quiet", "refs/remotes/origin/HEAD" })
				if default then
					table.insert(bases, 1, default)
				end
				for _, base in ipairs(bases) do
					if git({ "rev-parse", "--verify", "--quiet", base .. "^{commit}" }) then
						require("diffview").file_history(nil, { "-C" .. root, "--range=" .. base .. "..HEAD" })
						return
					end
				end
				vim.notify("Branch review: no valid origin default branch, main, or master ref found",
					vim.log.levels.WARN)
			end,
			desc = "Review branch history",
		},
	},
	opts = {
		show_help_hints = false,
		default_args = {
			DiffviewOpen = { "--imply-local" },
		},
		file_history_panel = {
			win_config = {
				height = 12,
			},
		},
	},
}
