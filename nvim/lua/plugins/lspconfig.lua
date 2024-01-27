return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'folke/neodev.nvim',
		'folke/neoconf.nvim',
		"themaxmarchuk/tailwindcss-colors.nvim",
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		require('neodev').setup({})
		require('neoconf').setup({})
		require("tailwindcss-colors").setup()
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		lspconfig.nginx_language_server.setup({ capabilities = capabilities })
		lspconfig.tsserver.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.html.setup({ capabilities = capabilities })

		lspconfig.intelephense.setup({ capabilities = capabilities })
		lspconfig.bashls.setup({
			capabilities = capabilities,
			filetypes = {
				'sh',
				'zsh',
			},
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
						disable = { 'missing-parameters', 'missing-fields' },
					},
				},
			},
		})

		-- CSS
		lspconfig.tailwindcss.setup({ capabilities = capabilities })
		capabilities.textDocument.completion.completionItem.snippetSupport =
			true

		lspconfig.cssls.setup({ capabilities = capabilities })
	end,

}
