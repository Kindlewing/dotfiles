-- treesitter highlighting
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- diagnostics float on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- yaml uses 2-space indentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "yaml", "yml" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- convert tabs to spaces before saving so yamlfmt always sees valid yaml
-- registered at startup (before conform loads lazily) so it runs first
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.yaml", "*.yml" },
	callback = function()
		vim.cmd("retab")
	end,
})

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- netrw: h/l for up/enter
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local map = vim.keymap.set
		map("n", "h", "-", { buffer = true, remap = true })
		map("n", "l", "<CR>", { buffer = true, remap = true })
	end,
})
