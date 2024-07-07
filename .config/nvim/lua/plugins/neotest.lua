return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- adaptors
		"nvim-neotest/neotest-go",
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message =
						diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go"),
			},
			discovery = {
				enabled = false,
				concurrent = 1,
			},
			output = {
				enabled = true,
				open_on_run = false,
			},
		})
	end,
	keys = {
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "test run file",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "test all files",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "test stop",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "test nearest",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "test last",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "test summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "test output",
		},
	},
}
