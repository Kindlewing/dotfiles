-- statusline.lua — heirline.nvim

vim.o.showmode = false
vim.g.qf_disable_statusline = 1

local heirline   = require("heirline")
local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")
local icons      = require("core").config.icons

-- ─── Palette ──────────────────────────────────────────────────────────────────

local function setup_colors()
	local function hl_fg(group)
		local ok, v = pcall(utils.get_highlight, group)
		return ok and v.fg or nil
	end
	local function hl_bg(group)
		local ok, v = pcall(utils.get_highlight, group)
		return ok and v.bg or nil
	end
	return {
		bg         = hl_bg("StatusLine"),
		fg         = hl_fg("StatusLine"),
		bright     = hl_fg("Normal"),
		muted      = hl_fg("Comment"),
		red        = hl_fg("DiagnosticError"),
		yellow     = hl_fg("DiagnosticWarn"),
		green      = hl_fg("String"),
		blue       = hl_fg("Function"),
		cyan       = hl_fg("Type"),
		purple     = hl_fg("Statement"),
		orange     = hl_fg("Constant"),
		diag_error = hl_fg("DiagnosticError"),
		diag_warn  = hl_fg("DiagnosticWarn"),
		diag_info  = hl_fg("DiagnosticInfo"),
		diag_hint  = hl_fg("DiagnosticHint"),
		git_add    = hl_fg("GitSignsAdd"),
		git_chg    = hl_fg("GitSignsChange"),
		git_del    = hl_fg("GitSignsDelete"),
	}
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function() utils.on_colorscheme(setup_colors()) end,
})

-- ─── Mode ─────────────────────────────────────────────────────────────────────

local mode_map = {
	n         = { "NORMAL",   "green"  },
	no        = { "OP·PEND",  "yellow" },
	nov       = { "OP·PEND",  "yellow" },
	noV       = { "OP·PEND",  "yellow" },
	niI       = { "NORMAL",   "green"  },
	niR       = { "NORMAL",   "green"  },
	niV       = { "NORMAL",   "green"  },
	nt        = { "NORMAL",   "green"  },
	ntT       = { "NORMAL",   "green"  },
	v         = { "VISUAL",   "purple" },
	vs        = { "VISUAL",   "purple" },
	V         = { "V·LINE",   "purple" },
	Vs        = { "V·LINE",   "purple" },
	s         = { "SELECT",   "cyan"   },
	S         = { "S·LINE",   "cyan"   },
	i         = { "INSERT",   "blue"   },
	ic        = { "INSERT",   "blue"   },
	ix        = { "INSERT",   "blue"   },
	R         = { "REPLACE",  "red"    },
	Rc        = { "REPLACE",  "red"    },
	Rx        = { "REPLACE",  "red"    },
	Rv        = { "V·REPL",   "red"    },
	Rvc       = { "V·REPL",   "red"    },
	Rvx       = { "V·REPL",   "red"    },
	c         = { "COMMAND",  "orange" },
	cv        = { "VIM·EX",   "orange" },
	ce        = { "EX",       "orange" },
	r         = { "PROMPT",   "muted"  },
	rm        = { "MORE",     "muted"  },
	t         = { "TERMINAL", "cyan"   },
	["no\22"] = { "OP·PEND",  "yellow" },
	["\22"]   = { "V·BLOCK",  "purple" },
	["\22s"]  = { "V·BLOCK",  "purple" },
	["\19"]   = { "S·BLOCK",  "cyan"   },
	["r?"]    = { "CONFIRM",  "orange" },
	["!"]     = { "SHELL",    "red"    },
}

local Mode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
		local m = mode_map[self.mode] or { "?", "muted" }
		self.mode_name  = m[1]
		self.mode_color = m[2]
	end,
	update = {
		"ModeChanged",
		pattern  = "*:*",
		callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
	},
	-- left cap
	{ provider = "", hl = function(self) return { fg = self.mode_color } end },
	-- label
	{
		provider = function(self) return " " .. self.mode_name .. " " end,
		hl       = function(self) return { fg = "bg", bg = self.mode_color, bold = true } end,
	},
	-- right cap
	{ provider = "", hl = function(self) return { fg = self.mode_color } end },
}

-- ─── Git ──────────────────────────────────────────────────────────────────────

local Git = {
	condition = conditions.is_git_repo,
	init = function(self)
		local s      = vim.b.gitsigns_status_dict or {}
		self.head    = vim.b.gitsigns_head or ""
		self.added   = s.added   or 0
		self.changed = s.changed or 0
		self.removed = s.removed or 0
	end,
	-- branch
	{
		provider = function(self) return "  " .. self.head end,
		hl       = { fg = "green", bold = true },
	},
	-- diff counts
	{
		condition = function(self) return self.added > 0 end,
		provider  = function(self) return " " .. icons.git.added .. self.added end,
		hl        = { fg = "git_add" },
	},
	{
		condition = function(self) return self.changed > 0 end,
		provider  = function(self) return " " .. icons.git.modified .. self.changed end,
		hl        = { fg = "git_chg" },
	},
	{
		condition = function(self) return self.removed > 0 end,
		provider  = function(self) return " " .. icons.git.removed .. self.removed end,
		hl        = { fg = "git_del" },
	},
}

-- ─── LSP progress ─────────────────────────────────────────────────────────────

local _lsp = { client = nil, title = nil }

vim.api.nvim_create_autocmd("LspProgress", {
	group   = vim.api.nvim_create_augroup("heirline/statusline", { clear = true }),
	pattern = { "begin", "end" },
	callback = function(args)
		if not args.data then return end
		_lsp = {
			client = vim.lsp.get_client_by_id(args.data.client_id).name,
			kind   = args.data.result.value.kind,
			title  = args.data.result.value.title,
		}
		if _lsp.kind == "end" then
			_lsp.title = nil
			vim.defer_fn(function() vim.cmd.redrawstatus() end, 3000)
		else
			vim.cmd.redrawstatus()
		end
	end,
})

local LspProgress = {
	condition = function() return _lsp.client ~= nil and _lsp.title ~= nil end,
	{ provider = "󱥸 ",                                    hl = { fg = "blue" } },
	{ provider = function() return _lsp.client .. "  " end, hl = { fg = "bright", bold = true } },
	{ provider = function() return _lsp.title .. "…" end,   hl = { fg = "muted", italic = true } },
	{ provider = "  " },
}

-- ─── DAP ──────────────────────────────────────────────────────────────────────

local Dap = {
	condition = function()
		return package.loaded["dap"] and require("dap").status() ~= ""
	end,
	provider = function() return "  " .. require("dap").status() .. " " end,
	hl       = { fg = "red" },
}

-- ─── Diagnostics ──────────────────────────────────────────────────────────────

local Diagnostics = {
	condition = conditions.has_diagnostics,
	update    = { "DiagnosticChanged", "BufEnter" },
	init = function(self)
		self.e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN  })
		self.i = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO  })
		self.h = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT  })
	end,
	{
		condition = function(self) return self.e > 0 end,
		provider  = function(self) return icons.diagnostics.Error .. self.e .. " " end,
		hl        = { fg = "diag_error" },
	},
	{
		condition = function(self) return self.w > 0 end,
		provider  = function(self) return icons.diagnostics.Warn  .. self.w .. " " end,
		hl        = { fg = "diag_warn" },
	},
	{
		condition = function(self) return self.i > 0 end,
		provider  = function(self) return icons.diagnostics.Info  .. self.i .. " " end,
		hl        = { fg = "diag_info" },
	},
	{
		condition = function(self) return self.h > 0 end,
		provider  = function(self) return icons.diagnostics.Hint  .. self.h .. " " end,
		hl        = { fg = "diag_hint" },
	},
}

-- ─── File ─────────────────────────────────────────────────────────────────────

local FileBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	-- icon
	{
		init = function(self)
			local name = vim.fn.fnamemodify(self.filename, ":t")
			local ext  = vim.fn.fnamemodify(self.filename, ":e")
			self.icon, self.icon_hl =
				require("nvim-web-devicons").get_icon(name, ext, { default = true })
		end,
		provider = function(self) return self.icon and (self.icon .. " ") end,
		hl       = function(self) return self.icon_hl end,
	},
	-- name
	{
		provider = function(self)
			local name = vim.fn.fnamemodify(self.filename, ":~:.")
			if name == "" then return "[No Name]" end
			if #name > 40 then name = "…" .. name:sub(-39) end
			return name
		end,
		hl = { fg = "bright" },
	},
	-- modified marker
	{
		condition = function() return vim.bo.modified end,
		provider  = " ●",
		hl        = { fg = "orange" },
	},
	-- read-only marker
	{
		condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
		provider  = " 󰌾",
		hl        = { fg = "red" },
	},
}

-- ─── File type ────────────────────────────────────────────────────────────────

local FileType = {
	condition = function() return vim.bo.filetype ~= "" end,
	provider  = function() return "  " .. vim.bo.filetype end,
	hl        = { fg = "muted" },
}

-- ─── Ruler ────────────────────────────────────────────────────────────────────

local Ruler = {
	{ provider = "", hl = { fg = "muted" } },
	{ provider = " %l/%L  %c ", hl = { fg = "bg", bg = "muted", bold = true } },
	{ provider = "", hl = { fg = "muted" } },
}

-- ─── Separator ────────────────────────────────────────────────────────────────

local Sep = { provider = "  │  ", hl = { fg = "muted" } }

-- ─── Statusline variants ──────────────────────────────────────────────────────

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype  = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,
	{ provider = " " },
	FileType,
	{ provider = "  %q%=" },
}

local InactiveStatusline = {
	condition = conditions.is_not_active,
	{ provider = " " },
	FileBlock,
	{ provider = "%=" },
	FileType,
	{ provider = " " },
}

local ActiveStatusline = {
	-- left
	{ provider = " " },
	Mode,
	Git,
	Sep,
	-- center
	{ provider = "%=" },
	FileBlock,
	{ provider = "%=" },
	-- right
	{ flexible = 3, LspProgress, { provider = "" } },
	Dap,
	Diagnostics,
	FileType,
	{ provider = " " },
	Ruler,
	{ provider = " " },
}

-- ─── Root ─────────────────────────────────────────────────────────────────────

heirline.setup({
	statusline = {
		hl = function()
			return conditions.is_active() and "StatusLine" or "StatusLineNC"
		end,
		fallthrough = false,
		SpecialStatusline,
		InactiveStatusline,
		ActiveStatusline,
	},
	opts = { colors = setup_colors() },
})
