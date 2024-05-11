return {
	"zbirenbaum/copilot.lua",
	enabled = function()
		local current_dir = vim.fn.expand('%:p:h') -- Get the full path of the current buffer's directory
		local ps_dir = vim.fn.expand('~/PS') -- Get the full path of ~/PS directory
		return not string.find(current_dir, ps_dir, 1, true)
	end,
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 50,
				keymap = {
					accept = "h<TAB>",
					next = "h]",
					prev = "h[",
				},
			},
			filetypes = {
				["*"] = true,
			},
		})
	end,
}
