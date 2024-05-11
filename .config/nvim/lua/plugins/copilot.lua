return {
	"zbirenbaum/copilot.lua",
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
