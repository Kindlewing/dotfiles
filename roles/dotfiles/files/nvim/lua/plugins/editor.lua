return {
	{
		"https://github.com/arborist-ts/arborist.nvim",
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
