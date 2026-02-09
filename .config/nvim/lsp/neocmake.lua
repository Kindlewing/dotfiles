local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
	cmd = { "neocmakelsp", "stdio" },
	filetypes = { "cmake" },
	root_markers = { ".git", "build", "cmake" },
	capabilities = capabilities,
}
