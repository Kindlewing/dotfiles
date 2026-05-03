---@type vim.lsp.Config
return {
	cmd = { "qmlls6", "-I", "/usr/lib/qt6/qml" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".qmlls.ini", ".git" },
	on_new_config = function(config, root_dir)
		config.cmd = vim.deepcopy(config.cmd)
		vim.list_extend(config.cmd, { "-I", root_dir })
		local f = io.open(root_dir .. "/.qmlls.ini", "r")
		if f then
			local build_dir = f:read("*a"):match('buildDir="([^"]+)"')
			f:close()
			if build_dir then
				vim.list_extend(config.cmd, { "-I", build_dir })
			end
		end
	end,
}
