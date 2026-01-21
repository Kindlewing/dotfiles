local opt = vim.opt

opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = nosplit
opt.mouse = ""
opt.clipboard = "unnamedplus"
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = false
opt.expandtab = false
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = { "menuone", "noselect" }
opt.undofile = true
opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.colorcolumn = "100"

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
