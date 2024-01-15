return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'folke/neodev.nvim',
		'folke/neoconf.nvim',
		'hrsh7th/cmp-nvim-lsp'
	},
	config = function()
		require('neodev').setup({})
		require('neoconf').setup({})
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		lspconfig.tsserver.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.intelephense.setup({ capabilities = capabilities })
		lspconfig.html.setup({ capabilities = capabilities })

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
				},
			},
		})

		-- CSS
		capabilities.textDocument.completion.completionItem.snippetSupport =
			true

		lspconfig.cssls.setup({ capabilities = capabilities })
	end,
}
