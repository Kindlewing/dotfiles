-- Theme style
	vim.g.material_style = 'deep ocean'

    -- Colorscheme settings
		require('lualine').setup {
		  options = {
				theme = 'material'
		  }
		}

	require('material').setup({
		contrast = {
			sidebars = true,
			floating_windows = false,
			line_numbers = false,
			sign_column = false,
			cursor_line = true,
			popup_menu = false
		},
		italics = {
			comments = true,
			strings = false,
			keywords = false,
			functions = true,
			variables = false
		},
		contrast_filetypes = {
			"terminal",
			"packer",
			"qf",
		},
		disable = {
			borders = true,
			background = false,
			term_colors = false,
			eob_lines = false
		},
		lualine_style = 'stealth'
	})

    -- Apply the colorscheme
    vim.cmd 'colorscheme material'
