return {
	'mfussenegger/nvim-dap',
	config = function()
		local dap = require('dap')
		local icons = require('config.icons.nerd')

		vim.fn.sign_define('DapBreakpoint', { text = icons.DapBreakpoint, texthl = '', linehl = '', numhl = '' })
		vim.fn.sign_define('DapStopped', { text = icons.DapStopped, texthl = '', linehl = '', numhl = '' })
		vim.fn.sign_define(
			'DapBreakpointRejected',
			{ text = icons.DapBreakpointRejected, texthl = '', linehl = '', numhl = '' }
		)
		dap.adapters.php = {
			type = 'executable',
			command = 'nodejs',
			args = { '/home/hudson/php-debug/out/phpDebug.js' },
		}
		dap.configurations.php = {
			{
				type = 'php',
				request = 'launch',
				name = 'Listen for Xdebug',
				port = '9000',
				log = true,
			},
		}
	end,
}
