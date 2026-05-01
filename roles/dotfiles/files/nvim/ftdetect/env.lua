vim.filetype.add({
	filename = {
		[".env"] = "dotenv",
	},
	pattern = {
		-- .env, .env.local, .env.production, .env.example, env.local, etc.
		["%.env"] = "dotenv",
		["%.env%..*"] = "dotenv",
		[".*/%.env"] = "dotenv",
		[".*/%.env%..*"] = "dotenv",
	},
})
