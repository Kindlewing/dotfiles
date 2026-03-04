return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-ts-autotag").setup({})

			require("nvim-treesitter").install({
				"tsx",
				"lua",
				"go",
				"gomod",
				"gowork",
				"vim",
				"typescript",
				"javascript",
				"html",
				"css",
				"json",
				"graphql",
				"regex",
				"rust",
				"prisma",
				"markdown",
				"markdown_inline",
			})
		end,
	},
}
