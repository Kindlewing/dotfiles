return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"igorlfs/nvim-dap-view",
		},
		config = function()
			local dap = require("dap")
			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = { "$HOME/vscode-php-debug/out/phpDebug.js" },
			}
			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9003,
				},
			}
		end,
	},
}
