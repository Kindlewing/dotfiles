return {
	{
		'sho-87/kanagawa-paper.nvim',
		lazy = false,
		priority = 1000,
		opts = function()
			local colors = require('kanagawa-paper.colors').setup()
			local palette = colors.palette
			return {
				undercurl = false,
				transparent = false,
				gutter = false,
				dimInactive = true, -- disabled when transparent
				terminalColors = true,
				commentStyle = { italic = true },
				functionStyle = { italic = false, bold = true },
				keywordStyle = { italic = true, bold = false },
				statementStyle = { italic = true, bold = false },
				typeStyle = { italic = true },
				colors = {
					theme = {
						syn = {
							string = palette.dragonGreen2,
							variable = 'none',
							member = palette.dragonOrange,
							number = palette.dragonPink,
							constant = palette.dragonOrange,
							identifier = palette.dragonYellow,
							parameter = palette.dragonGray,
							attribute = palette.dragonYellow,
							fun = palette.dragonBlue2,
							statement = palette.dragonViolet,
							keyword = palette.dragonPink,
							operator = palette.dragonRed,
							preproc = palette.dragonRed,
							type = palette.dragonBlue,
							regex = palette.dragonRed,
							deprecated = palette.katanaGray,
							punct = palette.dragonGray2,
							comment = palette.fujiGray,
							special1 = palette.dragonTeal,
							special2 = palette.dragonRed,
							special3 = palette.dragonBlue,
						},
						diag = {
							error = palette.dragonRed,
						},
					},
				},
			}
		end,
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 1000,
		opts = {
			flavour = 'mocha',
			styles = {
				functions = { 'italic' },
				comments = { 'italic' },
				conditionals = { 'italic' },
			},
			integrations = {
				cmp = true,
				indent_blankline = {
					enabled = false,
					scope_color = 'sapphire',
					colored_indent_levels = false,
				},
				mason = true,
				native_lsp = { enabled = true },
				notify = true,
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
			},
		},
	},
}
