return {
	"rickyelopez/uncrustify.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("uncrustify").setup({ format_timeout = 5000 })
	end,
}
