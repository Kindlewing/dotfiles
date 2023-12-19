return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
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
					'.git',
					'lazy-lock.json',
					'node_modules',
					'vendor',
					'%.lock',
					'schema.gql',
				},
				dynamic_preview_title = true,
				path_display = { 'smart' },
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			layout_config = {
				horizontal = {
					preview_cutoff = 100,
					preview_width = 0.5,
				},
			},
		})
	end,
}
