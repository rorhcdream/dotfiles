return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local lspconfig_util = require("lspconfig.util")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

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
		})

		lspconfig["bufls"].setup({
			capabilities = capabilities,
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
