return {
	'nvim-telescope/telescope.nvim',
	opts = {
		defaults = {
			file_ignore_patterns = {
				'vendor/',
				'node_modules/',
				'.git',
			},
		},
		pickers = {
			find_files = {
				hidden = true,
				no_ignore = true,
			},
		},
	},
}
