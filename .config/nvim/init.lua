local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local neovim = require("utils")
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "kanagawa" } },
	checker = { enabled = true },
})
vim.opt.rtp:prepend(lazypath)

require("icons")
require("opts")

vim.diagnostic.config({ virtual_text = false })
vim.cmd.colorscheme("kanagawa")

require("keymap")
require("highlights")

vim.cmd([[
augroup python
    autocmd!
    autocmd FileType python setlocal noexpandtab tabstop=4
augroup end
]])

vim.lsp.enable({
	"lua_ls",
	"bashls",
	"pyright",
	"tinymist",
	"clangd",
	"intelephense",
	"ols",
	"perlpls",
	"ts_ls",
	"html",
	"hyprls",
	"cssls",
	"twiggy_language_server",
	"asm_lsp",
	"neocmakelsp",
})
neovim.configure_signs()
