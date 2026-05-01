vim.filetype.add({
	filename = {
		[".gitignore"] = "gitignore",
		[".dockerignore"] = "gitignore", -- same syntax, reuse gitignore ft
		[".prettierignore"] = "gitignore",
		[".eslintignore"] = "gitignore",
		[".npmignore"] = "gitignore",
		[".stylelintignore"] = "gitignore",
	},
})
