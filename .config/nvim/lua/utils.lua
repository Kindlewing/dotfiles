local neovim = {}

local function escape_wildcards(path)
	return path:gsub("([%[%]%?%*])", "\\%1")
end

function neovim.strip_archive_subpath(path)
	-- Matches regex from zip.vim / tar.vim
	path =
		vim.fn.substitute(path, "zipfile://\\(.\\{-}\\)::[^\\\\].*$", "\\1", "")
	path = vim.fn.substitute(path, "tarfile:\\(.\\{-}\\)::.*$", "\\1", "")
	return path
end

--- Returns a function which matches a filepath against the given glob/wildcard patterns.
---
--- Also works with zipfile:/tarfile: buffers (via `strip_archive_subpath`).
function neovim.root_pattern(...)
	local patterns = neovim.tbl_flatten({ ... })
	return function(startpath)
		startpath = neovim.strip_archive_subpath(startpath)
		for _, pattern in ipairs(patterns) do
			local match = neovim.search_ancestors(startpath, function(path)
				for _, p in
					ipairs(
						vim.fn.glob(
							table.concat({ escape_wildcards(path), pattern }, "/"),
							true,
							true
						)
					)
				do
					if vim.uv.fs_stat(p) then
						return path
					end
				end
			end)

			if match ~= nil then
				return match
			end
		end
	end
end

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
	vim.fn.sign_define("DapBreakpointCondition", {
		text = icons.dap.BreakpointCondition,
		texthl = "DiagnosticInfo",
		numhl = "",
	})
	vim.fn.sign_define("DapBreakpointRejected", {
		text = icons.dap.BreakpointRejected[1],
		texthl = icons.dap.BreakpointRejected[2],
		numhl = "",
	})
	vim.fn.sign_define("DapStopped", {
		text = icons.dap.Stopped[1],
		texthl = icons.dap.Stopped[2],
		linehl = icons.dap.Stopped[3],
		numhl = "",
	})
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = icons.dap.LogPoint, texthl = "DiagnosticInfo", numhl = "" }
	)
end

return neovim
