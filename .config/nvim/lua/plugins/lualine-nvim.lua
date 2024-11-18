return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup(
			{
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff' },
					lualine_c = {
						'filename',
					},
					lualine_x = { 'diagnostics',
						{
							function()
								-- Get the current buffer number
								local bufnr = vim.api.nvim_get_current_buf()

								-- Define diagnostic severities in priority order
								local severities = {
									{ type = vim.diagnostic.severity.ERROR, label = "E", hl = "DiagnosticError" },
									{ type = vim.diagnostic.severity.WARN,  label = "W", hl = "DiagnosticWarn" },
									{ type = vim.diagnostic.severity.INFO,  label = "I", hl = "DiagnosticInfo" },
									{ type = vim.diagnostic.severity.HINT,  label = "H", hl = "DiagnosticHint" },
								}

								-- Iterate through severities to find the first diagnostic
								for _, severity in ipairs(severities) do
									local diagnostics = vim.diagnostic.get(bufnr, { severity = severity.type })
									if #diagnostics > 0 then
										-- Get the line number of the first diagnostic
										local line = diagnostics[1].lnum + 1 -- Convert to 1-based index
										-- Store the severity's highlight group dynamically
										vim.g.lualine_diagnostic_hl = severity.hl
										return string.format("%s:%d", severity.label, line)
									end
								end

								return '' -- No diagnostics found
							end,
							separator = { left = ' ' },
							color = function()
								-- Fetch the highlight group for the current severity
								local hl_group = vim.g.lualine_diagnostic_hl
								if hl_group then
									local hl = vim.api.nvim_get_hl(0, { name = hl_group })
									return { fg = hl.fg and string.format("#%06x", hl.fg) or nil, gui = 'bold' }
								end
								return { fg = 'white', gui = 'bold' } -- Default color
							end,
						},
					},
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
				extensions = {
					'fugitive',
					'lazy',
					'mason',
					'nvim-tree',
					'oil',
					'toggleterm',
				},
			}
		)
	end,
	enabled = true,
}
