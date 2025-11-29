return {
	"kiyoon/Korean-IME.nvim",
	keys = {
		-- lazy load on 한영전환
		{
			"<f12>",
			function()
				require("korean_ime").change_mode()
			end,
			mode = { "i", "n", "x", "s" },
			desc = "한/영",
		},
	},
	config = function()
		require("korean_ime").setup()

		vim.keymap.set("i", "<f9>", function()
			require("korean_ime").convert_hanja()
		end, { noremap = true, silent = true, desc = "한자" })
	end,
}
