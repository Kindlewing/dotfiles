return {
	{
		"ibhagwan/fzf-lua",
		opts = {
			files = {
				fd_opts = "--follow --type f --hidden --exclude .git",
			},
			grep = {
				rg_opts = "--follow --hidden --exclude .git",
			},
		},
	},
}
