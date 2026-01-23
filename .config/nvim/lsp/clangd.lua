local on_attach = function(client, bufnr)
	if client.name and client.name == "clangd" then
		vim.keymap.set(
			{ "n", "v" },
			"<leader>f",
			require("uncrustify").format,
			{ noremap = true }
		)
	end
end

return {
	cmd = { "clangd", "--background-index" },
	root_markers = { "compile_commands.json", "compile_flags.txt" },
	filetypes = { "c", "cpp" },
}
