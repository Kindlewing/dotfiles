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
				'prettier',
			},
		})

		require('mason-lspconfig').setup({
			ensure_installed = {
				'lua_ls',
				'tsserver',
				'html',
				'cssls',
				'tailwindcss',
				'rust_analyzer',
				'intelephense',
			},
		})
	end,
}
