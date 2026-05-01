return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = { "windwp/nvim-ts-autotag" },
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"go",
					"c",
					"html",
					"css",
				},
			})
			require("nvim-ts-autotag").setup({})
		end,
	},

	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.pairs").setup({})
			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
