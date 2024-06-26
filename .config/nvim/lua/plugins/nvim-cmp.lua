return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",

		-- LuaSnip
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",

		-- lspkind
		"onsails/lspkind-nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- -- Snippet jump with <Tab> and <S-Tab>
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						print('a')
						cmp.confirm({ select = false })
					elseif luasnip.expand_or_locally_jumpable() then
						print('b')
						luasnip.expand_or_jump()
					else
						print('c')
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" })

				-- -- Snippet jump with <C-j> and <C-k>
				-- ["<C-k>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	elseif luasnip.locally_jumpable(-1) then
				-- 		luasnip.jump(-1)
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
				-- ["<C-j>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_next_item()
				-- 	elseif luasnip.expand_or_locally_jumpable() then
				-- 		luasnip.expand_or_jump()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
				-- ["<Tab>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
			window = {
				documentation = cmp.config.window.bordered({
					border = "single",
				}),
				completion = cmp.config.window.bordered({
					winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
					side_padding = 0,
				}),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (strings[2] or "") .. ")"

					return kind
				end,
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline({
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<Tab>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = {
				{ name = "buffer" },
			},
			view = {
				entries = {
					name = 'wildmenu',
				},
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		local function set_highlight()
			vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#7E8294", bg = "NONE", italic = true })

			vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#B5585F" })
			vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#B5585F" })
			vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#B5585F" })

			vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#9FBD73" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#9FBD73" })
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#9FBD73" })

			vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#D4BB6C" })
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#D4BB6C" })
			vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#D4BB6C" })

			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#A377BF" })

			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#7E8294" })
			vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#7E8294" })

			vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#D4A959" })
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#D4A959" })
			vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#D4A959" })

			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#6C8ED4" })
			vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#6C8ED4" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#6C8ED4" })

			vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#58B5A8" })
			vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#58B5A8" })
			vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#58B5A8" })
		end
		set_highlight()
	end,
}
