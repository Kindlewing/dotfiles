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
							member = palette.fujiWhite,
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
							error = colors.palette.dragonRed,
						},
					},
					palette = {},
				}, -- override default palette and theme colors
				overrides = function(colors) -- override highlight groups
					local theme = colors.theme
					return {
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
					}
				end,
			}
		end,
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 1000,
		opts = {
			flavour = 'frappe',
			transparent_background = true,
			styles = {
				functions = { 'italic' },
				keywords = { 'bold' },
				comments = { 'italic' },
				conditionals = { 'italic' },
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				harpoon = true,
				illuminate = true,
				indent_blankline = {
					enabled = false,
					scope_color = 'sapphire',
					colored_indent_levels = false,
				},
				mason = true,
				native_lsp = { enabled = true },
				notify = true,
				nvimtree = true,
				neotree = true,
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
			},
		},
	},
	{
		'neanias/everforest-nvim',
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require('everforest').setup({
				---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
				---Default is "medium".
				background = 'hard',
				---How much of the background should be transparent. 2 will have more UI
				---components be transparent (e.g. status line background)
				transparent_background_level = 0,
				---Whether italics should be used for keywords and more.
				italics = true,
				---Disable italic fonts for comments. Comments are in italics by default, set
				---this to `true` to make them _not_ italic!
				disable_italic_comments = false,
				---By default, the colour of the sign column background is the same as the as normal text
				---background, but you can use a grey background by setting this to `"grey"`.
				sign_column_background = 'none',
				---The contrast of line numbers, indent lines, etc. Options are `"high"` or
				---`"low"` (default).
				ui_contrast = 'low',
				---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
				---
				---When this option is used in conjunction with show_eob set to `false`, the
				---end of the buffer will only be hidden inside the active window. Inside
				---inactive windows, the end of buffer filler characters will be visible in
				---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
				dim_inactive_windows = false,
				---Some plugins support highlighting error/warning/info/hint texts, by
				---default these texts are only underlined, but you can use this option to
				---also highlight the background of them.
				diagnostic_text_highlight = false,
				---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
				diagnostic_virtual_text = 'coloured',
				---Some plugins support highlighting error/warning/info/hint lines, but this
				---feature is disabled by default in this colour scheme.
				diagnostic_line_highlight = false,
				---By default, this color scheme won't colour the foreground of |spell|, instead
				---colored under curls will be used. If you also want to colour the foreground,
				---set this option to `true`.
				spell_foreground = false,
				---Whether to show the EndOfBuffer highlight.
				show_eob = true,
				---Style used to make floating windows stand out from other windows. `"bright"`
				---makes the background of these windows lighter than |hl-Normal|, whereas
				---`"dim"` makes it darker.
				---
				---Floating windows include for instance diagnostic pop-ups, scrollable
				---documentation windows from completion engines, overlay windows from
				---installers, etc.
				---
				---NB: This is only significant for dark backgrounds as the light palettes
				---have the same colour for both values in the switch.
				float_style = 'bright',
				---Inlay hints are special markers that are displayed inline with the code to
				---provide you with additional information. You can use this option to customize
				---the background color of inlay hints.
				---
				---Options are `"none"` or `"dimmed"`.
				inlay_hints_background = 'none',
				---You can override specific highlights to use other groups or a hex colour.
				---This function will be called with the highlights and colour palette tables.
				---@param highlight_groups Highlights
				---@param palette Palette
				on_highlights = function(highlight_groups, palette) end,
				---You can override colours in the palette to use different hex colours.
				---This function will be called once the base and background colours have
				---been mixed on the palette.
				---@param palette Palette
				colours_override = function(palette) end,
			})
		end,
	},
}
