vim.filetype.add({
	pattern = {
		[".*%.ya?ml"] = {
			function(path, bufnr)
				local dir = vim.fn.fnamemodify(path, ":h")
				while dir ~= "/" do
					if vim.fn.filereadable(dir .. "/ansible.cfg") == 1 then
						return "yaml.ansible"
					end
					dir = vim.fn.fnamemodify(dir, ":h")
				end
			end,
			priority = -1, -- run after other yaml rules, only claim if nothing else matched
		},
	},
})
