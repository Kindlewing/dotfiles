return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')

		-- Rust
		lspconfig.rust_analyzer.setup({})

		lspconfig.tsserver.setup({})
		lspconfig.intelephense.setup({})

		-- lua
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
