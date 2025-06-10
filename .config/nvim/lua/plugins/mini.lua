return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function(opts)
		require("mini.pairs").setup({})
		require("mini.surround").setup({})
	end,
}
