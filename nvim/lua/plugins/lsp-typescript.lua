return {
	'pmizio/typescript-tools.nvim',
	dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
	config = function()
		local keymap = vim.keymap

		local api = require('typescript-tools.api')
		require('typescript-tools').setup({
			handlers = {
				['textDocument/publishDiagnostics'] = api.filter_diagnostics({
					6133,
				}),
			},
			settings = {
				tsserver_file_preferences = {
					importModuleSpecifierPreference = 'non-relative',
				},
			},
		})
	end,
}
