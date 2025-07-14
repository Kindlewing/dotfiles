local neovim = {}

neovim.config = {
	icons = {
		misc = {
			dots = "󰇘",
		},
		ft = {
			octo = "",
		},
		dap = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		},
		diagnostics = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		},
		git = {
			added = " ",
			modified = " ",
			removed = " ",
		},
		kinds = {
			Array = " ",
			Boolean = "󰨙 ",
			Class = " ",
			Codeium = "󰘦 ",
			Color = " ",
			Control = " ",
			Collapsed = " ",
			Constant = "󰏿 ",
			Constructor = " ",
			Copilot = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = "󰊕 ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Method = "󰊕 ",
			Module = " ",
			Namespace = "󰦮 ",
			Null = " ",
			Number = "󰎠 ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = "󱄽 ",
			String = " ",
			Struct = "󰆼 ",
			Supermaven = " ",
			TabNine = "󰏚 ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = "󰀫 ",
		},
	},
}

function neovim.configure_signs()
	local icons = neovim.config.icons

	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
				[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
				[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
				[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
			},
		},
	})

	vim.fn.sign_define(
		"GitSignsAdd",
		{ text = icons.git.added, texthl = "GitSignsAdd", numhl = "" }
	)
	vim.fn.sign_define(
		"GitSignsChange",
		{ text = icons.git.modified, texthl = "GitSignsChange", numhl = "" }
	)
	vim.fn.sign_define(
		"GitSignsDelete",
		{ text = icons.git.removed, texthl = "GitSignsDelete", numhl = "" }
	)

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = icons.dap.Breakpoint, texthl = "DiagnosticInfo", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{
			text = icons.dap.BreakpointCondition,
			texthl = "DiagnosticInfo",
			numhl = "",
		}
	)
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{
			text = icons.dap.BreakpointRejected[1],
			texthl = icons.dap.BreakpointRejected[2],
			numhl = "",
		}
	)
	vim.fn.sign_define(
		"DapStopped",
		{
			text = icons.dap.Stopped[1],
			texthl = icons.dap.Stopped[2],
			linehl = icons.dap.Stopped[3],
			numhl = "",
		}
	)
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = icons.dap.LogPoint, texthl = "DiagnosticInfo", numhl = "" }
	)
end

return neovim
