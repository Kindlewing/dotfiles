vim.filetype.add({
	filename = {
		["Dockerfile"] = "dockerfile",
		["dockerfile"] = "dockerfile",
	},
	pattern = {
		-- Dockerfile variants: Dockerfile.dev, Dockerfile.prod, etc.
		["Dockerfile%..*"] = "dockerfile",
		[".*/Dockerfile%..*"] = "dockerfile",
		-- docker-compose variants
		["docker%-compose%.ya?ml"] = "yaml.docker-compose",
		["docker%-compose%..*%.ya?ml"] = "yaml.docker-compose",
		["compose%.ya?ml"] = "yaml.docker-compose",
		["compose%..*%.ya?ml"] = "yaml.docker-compose",
		[".*/docker%-compose%.ya?ml"] = "yaml.docker-compose",
		[".*/docker%-compose%..*%.ya?ml"] = "yaml.docker-compose",
		[".*/compose%.ya?ml"] = "yaml.docker-compose",
	},
})
