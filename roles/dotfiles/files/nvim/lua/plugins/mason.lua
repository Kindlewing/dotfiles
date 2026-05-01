return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"lua-language-server",
				"html-lsp",
				"ansible-language-server",
				"ansible-lint",
				"qmlls",
				"pyright",
				"clangd",
				"clang-format",
				"tinymist",
				"glsl_analyzer",
				"bash-language-server",
				"css-lsp",
				"intelephense",
			},
		},
		auto_update = true,
		start_delay = 500,
	},

	{
		"barrett-ruth/live-server.nvim",
		build = "npm install -g live-server --prefix ~/.local",
		cmd = { "LiveServerStart", "LiveServerStop" },
	},
}
