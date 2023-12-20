return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')
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
	end,
}
