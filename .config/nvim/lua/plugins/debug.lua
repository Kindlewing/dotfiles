return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		desc = "Debugging support for C/C++ using GDB",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
			},
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- 🧩 Setup UI
			dapui.setup()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "cppdbg" }, -- optional; GDB doesn't install via mason
				automatic_installation = false,
			})

			-- Auto-open/close UI
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- 🧠 GDB adapter setup
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			-- ⚙️ Configurations for C (and C++)
			dap.configurations.c = {
				{
					name = "Launch executable",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input(
							"Path to executable: ",
							vim.fn.getcwd() .. "/",
							"file"
						)
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}

			-- Make same setup work for C++
			dap.configurations.cpp = dap.configurations.c
		end,
	},
}
