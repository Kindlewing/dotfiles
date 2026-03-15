local opt = vim.opt

opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.mouse = ""
opt.clipboard = "unnamedplus"
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.swapfile = false
opt.autoread = true
opt.updatetime = 300
opt.cursorline = true
opt.background = "dark"
opt.colorcolumn = "90"
opt.termguicolors = true

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

vim.cmd.colorscheme("everforest")
