local modes = {
	n = "NOR",
	no = "NOR",
	i = "INS",
	ic = "INS",
	v = "VIS",
	V = "VLN",
	["\22"] = "VBK",
	c = "CMD",
	R = "REP",
	Rv = "REP",
	s = "SEL",
	S = "SLN",
	t = "TRM",
}

local function mode()
	return modes[vim.fn.mode()] or vim.fn.mode()
end

local function filename()
	local name = vim.fn.expand("%:~:.")
	if name == "" then
		name = "[No Name]"
	end
	return name .. (vim.bo.modified and " [+]" or "") .. (vim.bo.readonly and " [RO]" or "")
end

local function branch()
	local b = vim.b.gitsigns_head
	return (b and b ~= "") and (" " .. b) or ""
end

local function diagnostics()
	local d = vim.diagnostic.count(0)
	local s = vim.diagnostic.severity
	local parts = {}
	if (d[s.ERROR] or 0) > 0 then
		table.insert(parts, " " .. d[s.ERROR])
	end
	if (d[s.WARN] or 0) > 0 then
		table.insert(parts, " " .. d[s.WARN])
	end
	if (d[s.INFO] or 0) > 0 then
		table.insert(parts, " " .. d[s.INFO])
	end
	return table.concat(parts, " ")
end

local function lsp_client()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	return #clients > 0 and clients[1].name or ""
end

local function macro()
	local reg = vim.fn.reg_recording()
	return reg ~= "" and ("REC @" .. reg) or ""
end

local sep = "  "

function _G.statusline()
	local b = branch()
	local d = diagnostics()
	local l = lsp_client()
	local m = macro()
	local fmt = vim.b.disable_autoformat and "fmt:off" or "fmt:on"
	local ft = vim.bo.filetype

	local left = " " .. mode() .. sep .. filename() .. (b ~= "" and sep .. b or "")
	local mid = (d ~= "" and d or "") .. (m ~= "" and (d ~= "" and sep or "") .. m or "")
	local right = fmt .. sep .. (l ~= "" and l .. sep or "") .. (ft ~= "" and ft .. sep or "") .. "%l:%c "

	return left .. "%=" .. mid .. "%=" .. right
end

function _G.tabline()
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

vim.opt.statusline = "%!v:lua.statusline()"
vim.opt.showtabline = 2
vim.opt.tabline = "%!v:lua.tabline()"
