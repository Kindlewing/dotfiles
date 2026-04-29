local neovim = require("core")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "plugins" } },
	install = { colorscheme = { "gruvbox-material" } },
	checker = { enabled = false },
	change_detection = { enabled = false },
})

require("configs")
require("keymaps")
require("autocmds")
require("lsp")
neovim.configure_signs()
