return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')

		-- rust
		lspconfig.rust_analyzer.setup({})

		-- typescript
		lspconfig.tsserver.setup({})

		-- php
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
