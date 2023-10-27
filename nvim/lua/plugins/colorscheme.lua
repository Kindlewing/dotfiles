return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		opts = {
			flavour = 'mocha',
			dim_inactive = { enabled = true, shade = 'dark', percentage = 0.45 },
		},
	},
	{
		'LazyVim/LazyVim',
		opts = { colorscheme = 'catppuccin' },
	},
}
