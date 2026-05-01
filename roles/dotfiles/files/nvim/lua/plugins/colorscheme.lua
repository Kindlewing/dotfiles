local neovim = require("core")
return {
	{ "sainnhe/everforest", lazy = false, priority = 1000 },

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_transparent_background = 2
			vim.cmd.colorscheme(neovim.config.theme)
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "#32302f", blend = 80 })
		end,
	},
}
