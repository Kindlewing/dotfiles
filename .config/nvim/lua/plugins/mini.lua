return {
	'echasnovski/mini.nvim',
	version = '*',
	config = function(opts)
		require('mini.ai').setup({})
		require('mini.pairs').setup({})
		require('mini.operators').setup({})
		require('mini.surround').setup({})
	end,
}
