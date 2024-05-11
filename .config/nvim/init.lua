-- Mappings and options
vim.g.mapleader = ","

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.updatetime = 100
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"

vim.keymap.set({ "i", "t" }, "hh", "<Plug>esc")
vim.keymap.set("i", "jk", "<Plug>esc")
vim.keymap.set("i", "kj", "<Plug>esc")
vim.keymap.set("i", "<Plug>esc", "<ESC>")
vim.keymap.set("t", "<Plug>esc", "<C-\\><C-n>")
vim.keymap.set("n", "gb", "ls<CR>:b<Space>")
vim.keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { silent = true })
vim.keymap.set({ "i", "n", "t" }, "<leader>`", "<Plug>TermToggle")
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>")
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "Q", "<nop>")

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Customize color for the color scheme
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282a36", sp = "#282a36" })
		vim.api.nvim_set_hl(0, "Identifier", { fg = "white" })
		vim.api.nvim_set_hl(0, "Boolean", { fg = "#9aedfe" })
	end,
})

-- Set autoformat
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({
	{ import = "plugins" },
	{ import = "plugins.lsp" },
}, {
	change_detection = { notify = false },
})
