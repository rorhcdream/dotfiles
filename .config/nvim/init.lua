-- Mappings and options
vim.g.mapleader = ","

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 1
vim.opt.mousemoveevent = true

vim.keymap.set("t", "hh", "<Plug>esc")
vim.keymap.set("i", "jk", "<Plug>esc")
vim.keymap.set("i", "kj", "<Plug>esc")
vim.keymap.set("i", "<Plug>esc", "<ESC>")
vim.keymap.set("t", "<Plug>esc", "<C-\\><C-n>")
vim.keymap.set("n", "gb", "ls<CR>:b<Space>")
vim.keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { silent = true })
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>")
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>")
vim.keymap.set("n", "Q", "<nop>")

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Set up shell for Windows
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.o.shell = "powershell"
	vim.o.shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end

-- Customize color for the color scheme
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282a36", sp = "#282a36" })
		vim.api.nvim_set_hl(0, "Identifier", { fg = "white" })
		vim.api.nvim_set_hl(0, "Boolean", { fg = "#9aedfe" })
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
