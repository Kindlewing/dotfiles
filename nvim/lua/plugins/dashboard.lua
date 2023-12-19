return {
	'nvimdev/dashboard-nvim',
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
	event = 'VimEnter',
	config = function()
		require('dashboard').setup({
			theme = 'hyper',
			week_header = { enable = true },
			packages = { enable = true },
		})
	end,
}
