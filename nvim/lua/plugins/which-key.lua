return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { 'n', 'v' },
			['g'] = { name = 'Goto' },
			['gz'] = { name = 'Surround' },
			[']'] = { name = 'Next' },
			['['] = { name = 'Prev' },
			['<leader>m'] = { name = 'Markdown' },
			['<leader><tab>'] = { name = 'Tabs' },
			['<leader>b'] = { name = 'Buffer' },
			['<leader>c'] = { name = 'Code' },
			['<leader>f'] = { name = 'File/find' },
			['<leader>g'] = { name = 'Git' },
			['<leader>gh'] = { name = 'Hunks' },
			['<leader>q'] = { name = 'Quit/Session' },
			['<leader>s'] = { name = 'Search' },
			['<leader>u'] = { name = 'UI' },
			['<leader>w'] = { name = 'Windows' },
			['<leader>x'] = { name = 'Diagnostics/Quickfix' },
		},
	},
	config = function(_, opts)
		local wk = require('which-key')
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
