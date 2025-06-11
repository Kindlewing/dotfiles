return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				defaults = {
					mappings = {
						i = {
							["esc"] = actions.close,
						},
					},
					file_ignore_patterns = {
						".git/",
						"lazy-lock.json",
						"compile_commands.json",
						"node_modules/",
						"target/",
						"vendor/",
						"build/",
						"bin/",
						".venv/",
						".cache/",
						"codegen.ts",
						".png",
						".jpg",
						".jpeg",
					},
					dynamic_preview_title = true,
					path_display = { "smart" },
				},
				pickers = {
					find_files = {
						follow = true,
						hidden = true,
						no_ignore = true,
					},
				},
				require("telescope").load_extension("fzf"),
				require("telescope").load_extension("ui-select"),
			},
		})
	end,
}
