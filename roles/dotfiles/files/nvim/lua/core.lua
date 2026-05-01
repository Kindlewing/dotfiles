local neovim = {}
neovim.config = {
	theme = "gruvbox-material",
	icons = {
		misc = {
			dots = "󰇘",
		},
		ft = {
			octo = "󰊢",
		},
		dap = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		},
		diagnostics = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		},
		git = {
			added = " ",
			modified = " ",
			removed = " ",
			branch = " ",
		},
		-- Non-standard AI completion kinds not covered by mini.icons
		kinds = {
			Codeium = "󰘦 ",
			Control = " ",
			Collapsed = " ",
			Copilot = " ",
			Supermaven = " ",
			TabNine = "󰏚 ",
		},
	},
}

local lsp_kinds = {
	"Array",
	"Boolean",
	"Class",
	"Color",
	"Constant",
	"Constructor",
	"Enum",
	"EnumMember",
	"Event",
	"Field",
	"File",
	"Folder",
	"Function",
	"Interface",
	"Key",
	"Keyword",
	"Method",
	"Module",
	"Namespace",
	"Null",
	"Number",
	"Object",
	"Operator",
	"Package",
	"Property",
	"Reference",
	"Snippet",
	"String",
	"Struct",
	"Text",
	"TypeParameter",
	"Unit",
	"Value",
	"Variable",
}

function neovim.init_ansible()
	if vim.filetype then
		vim.filetype.add({
			pattern = {
				[".*/defaults/.*%.ya?ml"] = "yaml.ansible",
				[".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
				[".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
				[".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
				[".*/playbook.*%.ya?ml"] = "yaml.ansible",
				[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
				[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
				[".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
				[".*/pre_tasks/.*%.ya?ml"] = "yaml.ansible",
				[".*/pre_tasks/.*/.*%.ya?ml"] = "yaml.ansible",
				[".*/tasks/.*%.ya?ml"] = "yaml.ansible",
				[".*/molecule/.*%.ya?ml"] = "yaml.ansible",
			},
		})
	else
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = {
				"*/defaults/*.yml",
				"*/defaults/*.yaml",
				"*/host_vars/*.yml",
				"*/host_vars/*.yaml",
				"*/group_vars/*.yml",
				"*/group_vars/*.yaml",
				"*/group_vars/*/*.yml",
				"*/group_vars/*/*.yaml",
				"*/playbook*.yml",
				"*/playbook*.yaml",
				"*/playbooks/*.yml",
				"*/playbooks/*.yaml",
				"*/roles/*/tasks/*.yml",
				"*/roles/*/tasks/*.yaml",
				"*/roles/*/handlers/*.yml",
				"*/roles/*/handlers/*.yaml",
				"*/tasks/*.yml",
				"*/tasks/*.yaml",
				"*/molecule/*.yml",
				"*/molecule/*.yaml",
			},
			callback = function()
				vim.bo.filetype = "yaml.ansible"
			end,
		})
	end
end

function neovim.configure_signs()
	local icons = neovim.config.icons

	for _, name in ipairs(lsp_kinds) do
		local icon = MiniIcons.get("lsp", name)
		icons.kinds[name] = icon .. " "
	end

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

	vim.fn.sign_define("GitSignsAdd", { text = icons.git.added, texthl = "GitSignsAdd", numhl = "" })
	vim.fn.sign_define("GitSignsChange", { text = icons.git.modified, texthl = "GitSignsChange", numhl = "" })
	vim.fn.sign_define("GitSignsDelete", { text = icons.git.removed, texthl = "GitSignsDelete", numhl = "" })

	vim.fn.sign_define("DapBreakpoint", { text = icons.dap.Breakpoint, texthl = "DiagnosticInfo", numhl = "" })
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
	vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DiagnosticInfo", numhl = "" })
end

return neovim
