return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
	},
	config = function()
		require('mason').setup({
			ui = {
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
			ensure_installed = {
				'stylua',
				'eslint_d',
				'prettier',
			},
		})

		require('mason-lspconfig').setup({
			ensure_installed = {
				'lua_ls',
				'tsserver',
				'rust_analyzer',
				'intelephense',
			},
		})
	end,
}
