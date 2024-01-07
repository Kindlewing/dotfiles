return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'folke/neodev.nvim',
	},
	config = function()
		local lspconfig = require('lspconfig')
		require('neodev').setup()
		lspconfig.rust_analyzer.setup({})
		lspconfig.tsserver.setup({})
		lspconfig.intelephense.setup({})
		lspconfig.html.setup({})

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
				},
			},
		})

		-- CSS
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport =
			true

		lspconfig.cssls.setup({ capabilities = capabilities })
	end,
}
