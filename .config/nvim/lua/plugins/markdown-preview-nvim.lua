return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	keys = {
		{ "<leader>m", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview", ft = "markdown" },
	},
	build = function() vim.fn["mkdp#util#install"]() end,
	config = function()
		vim.g.mkdp_auto_close = 0
		-- Chrome steals focus even with `open -g` or AppleScript tab creation, so a
		-- detached poll loop snaps focus back the moment it is stolen (~0.3s flash),
		-- guarding ~1s in case the browser raises itself again on page load.
		function _G.MkdpOpenBg(url)
			vim.fn.jobstart({ "sh", "-c", [[
				front=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true')
				open -g "$1"
				for i in $(seq 1 10); do
					cur=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true')
					[ "$cur" != "$front" ] && osascript -e "tell application \"$front\" to activate"
					sleep 0.1
				done
			]], "", url })
		end
		vim.cmd([[
			function! MkdpOpenInBackground(url)
				call v:lua.MkdpOpenBg(a:url)
			endfunction
		]])
		vim.g.mkdp_browserfunc = "MkdpOpenInBackground"
	end
}
