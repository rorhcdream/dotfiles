return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"lukas-reineke/lsp-format.nvim",
		{ "creativenull/efmls-configs-nvim",     vrsion = "v1.x.x" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local lspconfig_util = require("lspconfig.util")
		local lspformat = require("lsp-format")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		lspformat.setup()
		vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

		local function setup_border()
			local border = {
				{ '┌', 'FloatBorder' },
				{ '─', 'FloatBorder' },
				{ '┐', 'FloatBorder' },
				{ '│', 'FloatBorder' },
				{ '┘', 'FloatBorder' },
				{ '─', 'FloatBorder' },
				{ '└', 'FloatBorder' },
				{ '│', 'FloatBorder' },
			}

			-- To instead override globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end
		end
		setup_border()

		local opts = { silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to definition"
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "See available code actions"
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Rename"
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

			opts.desc = "Show documents"
			vim.keymap.set("n", "K", function()
				vim.opt.eventignore = "CursorHold"
				vim.lsp.buf.hover()
				vim.api.nvim_create_autocmd("CursorMoved", {
					callback = function()
						vim.opt.eventignore = ""
					end,
					buffer = 0,
					once = true,
				})
			end, opts)

			lspformat.on_attach(client, bufnr)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.offsetEncoding = { "utf-16" }

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["golangci_lint_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "c", "cpp" },
		})

		local rust_initialized = false
		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			on_new_config = function(new_config, new_root_dir)
				if rust_initialized then
					return
				end
				rust_initialized = true

				print("Initialize rust-analyer: Register detached files if CWD not in a Cargo project")
				local function get_init_options()
					local get_root = lspconfig_util.root_pattern('.git', 'Cargo.toml', 'rust-project.json')
					local root = get_root(vim.loop.cwd())
					local function exists(path)
						return lspconfig_util.path.exists(
							lspconfig_util.path.join(root, path)
						)
					end
					if exists('Cargo.toml') or exists('rust-project.json') then
						return {}
					end

					local detachedFiles = {}
					for file in string.gmatch(vim.fn.globpath(root, '**/*.rs'), '[%S]+') do
						table.insert(detachedFiles, file)
					end
					return {
						detachedFiles = detachedFiles,
					}
				end
				new_config.init_options = get_init_options()
			end,
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			on_new_config = function(new_config, new_root_dir)
				-- Pyright is launched in a separate shell, so we set the pyenv version here to use the current virtual env
				vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')
			end,
		})

		lspconfig["bufls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["eslint"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- https://github.com/creativenull/efmls-configs-nvim?tab=readme-ov-file#setup
		local efmls_languages = {
			python = {
				require('efmls-configs.formatters.black'),
				require('efmls-configs.formatters.isort'),
			},
			yaml = {
				require('efmls-configs.linters.yamllint'),
				require('efmls-configs.formatters.prettier'),
			},
		}

		lspconfig["efm"].setup({
			filetypes = vim.tbl_keys(efmls_languages),
			settings = {
				rootMarkers = { ".git/" },
				languages = efmls_languages,
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
			on_attach = on_attach,
		})

		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float({ scope = "cursor", focus = false })
			end,
		})


		-- For debugging
		-- vim.lsp.set_log_level("trace")
	end,
}
