return {
	'rorhcdream/sidecar.nvim',
	event = "VeryLazy",
	cmd = { "Sidecar", "SidecarSwitch", "SidecarAdd", "SidecarPrompt", "SidecarPromptFile" },
	opts = {
		tools = {
			claude = { cmd = "~/.local/bin/claude" },
			codex = { cmd = "codex" },
		},
	},
}
