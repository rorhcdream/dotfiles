return {
	'rorhcdream/sidecar.nvim',
	event = "VeryLazy",
	cmd = { "Sidecar", "SidecarSwitch", "SidecarAdd", "SidecarPrompt", "SidecarPromptFile" },
	opts = {
		tools = {
			claude = { cmd = "claude" },
			codex = { cmd = "codex -c check_for_update_on_startup=false" },
		},
	},
}
