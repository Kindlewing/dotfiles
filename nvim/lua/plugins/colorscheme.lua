return {
	'catppuccin/nvim',
	name = 'catppuccin',
	priority = 1000,
	opts = {
		flavor = 'mocha',
		color_overrides = {
			mocha = {
				base = '#1e1e2e',
				text = '#ffffff',
			},
		},
		integrations = {
			cmp = true,
			treesitter = true,
		},
	},
}
