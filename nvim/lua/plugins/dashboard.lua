return {
	'nvimdev/dashboard-nvim',
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
	event = 'VimEnter',
	config = function()
		require('dashboard').setup({
			theme = 'hyper',
		})
	end,
	requires = { 'nvim-tree/nvim-web-devicons' },
}
