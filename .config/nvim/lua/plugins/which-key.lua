return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		preset = "modern",
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},

		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
		},

		layout = {
			align = "center",
			spacing = 6,
		},

		show_help = false,
		show_keys = false,
	},
}
