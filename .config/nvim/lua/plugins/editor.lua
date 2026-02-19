return {
	{ "sainnhe/everforest", lazy = false, priority = 1000 },
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.pairs").setup({})
			require("mini.surround").setup({})
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{ "williamboman/mason.nvim", opts = {} },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"lua-language-server",
				"typescript-language-server",
				"html-lsp",
				"pyright",
				"dockerfile-language-server",
				"clangd",
				"clang-format",
				"marksman",
				"tinymist",
				"bash-language-server",
				"css-lsp",
				"neocmakelsp",
				"intelephense",
			},
			auto_update = true,
			start_delay = 500,
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
