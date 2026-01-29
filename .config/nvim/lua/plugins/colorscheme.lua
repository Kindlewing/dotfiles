return {
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
		end,
	},
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.everforest_enable_italic = true
		end,
	},
	{
		"marko-cerovac/material.nvim",
		lazy = false, -- 🔴 IMPORTANT
		priority = 1000, -- load before others
		config = function()
			require("material").setup({
				style = "darker", -- darker | lighter | oceanic | palenight | deep ocean
			})
			vim.cmd.colorscheme("material")
		end,
	},
}
