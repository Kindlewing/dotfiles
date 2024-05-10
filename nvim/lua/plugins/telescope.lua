return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local actions = require('telescope.actions')

		require('telescope').setup({
			defaults = {
				mappings = {
					i = {
						['esc'] = actions.close,
					},
				},
				file_ignore_patterns = {
					'codegen.ts',
					'.git/',
					'lazy-lock.json',
					'compile_commands.json',
					'node_modules/',
					'target/',
					'vendor/',
					'build/',
					'.venv/',
					'.cache/',
					'.png',
					'.jpg',
					'.jpeg',
				},
				dynamic_preview_title = true,
				path_display = { 'smart' },
			},
			pickers = {
				find_files = {
					follow = true,
					hidden = true,
					no_ignore = true,
				},
			},
		})
	end,
}
