local icons = require("core").config.icons

local sl = {}

sl.sep = "  "
sl.modes = {
	n = "Normal",
	no = "Normal",
	i = "Insert",
	ic = "Insert",
	v = "Visual",
	V = "Visual Line",
	["\22"] = "Visual Block",
	c = "Command",
}

function sl.mode()
	return sl.modes[vim.fn.mode()] or vim.fn.mode()
end

function sl.filename()
	local name = vim.fn.expand("%:~:.")
	if name == "" then
		name = "[No Name]"
	end
	return name .. (vim.bo.modified and " [+]" or "") .. (vim.bo.readonly and " [RO]" or "")
end

function sl.branch()
	local b = vim.b.gitsigns_head
	return (b and b ~= "") and (icons.git.branch .. b) or ""
end

function sl.diagnostics()
	local d = vim.diagnostic.count(0)
	local s = vim.diagnostic.severity
	local parts = {}
	if (d[s.ERROR] or 0) > 0 then
		table.insert(parts, icons.diagnostics.Error .. d[s.ERROR])
	end
	if (d[s.WARN] or 0) > 0 then
		table.insert(parts, icons.diagnostics.Warn .. d[s.WARN])
	end
	if (d[s.INFO] or 0) > 0 then
		table.insert(parts, icons.diagnostics.Info .. d[s.INFO])
	end
	return table.concat(parts, " ")
end

function sl.lsp_client()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	return #clients > 0 and clients[1].name or ""
end

function sl.macro()
	local reg = vim.fn.reg_recording()
	return reg ~= "" and ("Recording @" .. reg) or ""
end

function sl.build()
	local b = sl.branch()
	local d = sl.diagnostics()
	local l = sl.lsp_client()
	local m = sl.macro()
	local sep = sl.sep
	local fmt = vim.b.disable_autoformat and "Format: off" or "Format: On"
	local ft = vim.bo.filetype

	local left = " " .. sl.mode() .. sep .. sl.filename() .. (b ~= "" and sep .. b or "")
	local mid = (d ~= "" and d or "") .. (m ~= "" and (d ~= "" and sep or "") .. m or "")
	local right = fmt .. sep .. (l ~= "" and l .. sep or "") .. (ft ~= "" and ft .. sep or "") .. "%l:%c "
	return left .. "%=" .. mid .. "%=" .. right
end

function sl.tabline()
	local s = ""
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			if name == "" then
				name = "[No Name]"
			end
			local mod = vim.bo[buf].modified and " [+]" or ""
			if buf == vim.api.nvim_get_current_buf() then
				s = s .. "%#TabLineSel# " .. name .. mod .. " %#TabLine#"
			else
				s = s .. "%#TabLine# " .. name .. mod .. " "
			end
		end
	end
	return s .. "%#TabLineFill#"
end

function _G.statusline()
	return sl.build()
end

function _G.tabline()
	return sl.tabline()
end

vim.opt.statusline = "%!v:lua.statusline()"
vim.opt.showtabline = 2
vim.opt.tabline = "%!v:lua.tabline()"
