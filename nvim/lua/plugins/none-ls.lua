return {
	'nvimtools/none-ls.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = { 'mason.nvim' },
	opts = function()
		local nls = require('null-ls')
		return {
			sources = {
				nls.builtins.formatting.prettierd,
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.prettier,
				nls.builtins.formatting.beautysh,
				nls.builtins.formatting.phpcsfixer.with({ prefer_local = 'vendor/bin/php-cs-fixer' }),
				nls.builtins.formatting.blue,
				nls.builtins.diagnostics.flake8,
			},
		}
	end,
}
