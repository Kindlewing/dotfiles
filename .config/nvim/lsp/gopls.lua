---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.root(fname, { "go.work", "go.mod", ".git" }))
	end,
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			staticcheck = true,
		},
	},
}
