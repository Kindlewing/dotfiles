return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		opts = {
			ensure_installed = {
				"tsx",
				"lua",
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
			},

			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			autotag = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = false,
				},
			},
		},
	},

	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		config = function()
			require("template-string").setup({})
		end,
	},
}
