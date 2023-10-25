return {
	'williamboman/mason.nvim',
	cmd = 'Mason',
	keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
	opts = {
		ui = {
			icons = {
				package_installed = '✓',
				package_pending = '➜',
				package_uninstalled = '✗',
			},
		},
		ensure_installed = {
			'lua_ls',
			'shellcheck',
			'editorconfig-checker',
			'beautysh',
			'marksman',
			'shfmt',
			'flake8',
			'prettier',
			'prettierd',
			'rust-analyzer',
			'pyright',
			'blue',
			'bash-language-server',
			'rustfmt',
			'typescript-language-server',
			'php-cs-fixer',
			'tailwindcss-language-server',
			'css-lsp',
			'cssmodules-language-server',
			'emmet-language-server',
			'html-lsp',
		},
	},
	---@param opts MasonSettings | {ensure_installed: string[]}
	config = function(plugin, opts)
		require('mason').setup(opts)
		local mr = require('mason-registry')
		for _, tool in ipairs(opts.ensure_installed) do
			local p = mr.get_package(tool)
			if not p:is_installed() then
				p:install()
			end
		end
	end,
	'williamboman/mason-lspconfig.nvim',
}
