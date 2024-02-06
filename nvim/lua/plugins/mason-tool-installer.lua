return {
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	opts = {
		ensure_installed = {
			'stylua',
			'prettier',
			'lua_ls',
			'tsserver',
			'html',
			'pyright',
			'dockerls',
			'texlab',
			'docker_compose_language_service',
			'bashls',
			'cssls',
			'tailwindcss',
			'rust_analyzer',
			'gopls',
			'intelephense',
		},
		auto_update = true,
		start_delay = 500
	}
}
