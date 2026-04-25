return {
	cmd = { "ansible-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.ansible" },
	root_markers = { "ansible.cfg", ".ansible-lint", "playbooks", "roles" },
	settings = {
		ansible = {
			ansible = { path = "ansible" },
			executionEnvironment = { enabled = false },
			python = { interpreterPath = "python3" },
			validation = {
				enabled = true,
				lint = { enabled = true, path = "ansible-lint" },
			},
		},
	},
}
