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
opt.smarttab = false
opt.expandtab = false
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = { "menuone", "noselect" }
opt.undofile = true
opt.swapfile = false
opt.autoread = true
opt.cursorline = true
opt.background = "dark"
opt.colorcolumn = "90"

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"bashls",
	"pyright",
	"tinymist",
	"clangd",
	"intelephense",
	"ts_ls",
	"html",
	"cssls",
	"neocmake",
	"dockerls",
	"marksman",
})

vim.cmd.colorscheme("everforest")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("lazy").update({
			show = false,
			once = true,
		})
	end,
})
