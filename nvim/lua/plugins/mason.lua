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
			-- Formatters
			ensure_installed = {
				'stylua',
				'prettier',
			},
		})

		require('mason-lspconfig').setup({
			-- LSP
			ensure_installed = {
				'lua_ls',
				'tsserver',
				'html',
				'dockerls',
				'bashls',
				'cssls',
				'tailwindcss',
				'rust_analyzer',
				'gopls',
				'intelephense',
			},
		})
	end,
}
