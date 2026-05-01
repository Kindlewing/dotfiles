return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					nix = { "nixpkgs-format" },
					javascript = { "biome" },
					typescript = { "biome" },
					javascriptreact = { "biome" },
					typescriptreact = { "biome" },
					css = { "biome" },
					html = { "djlint" },
					json = { "biome" },
					yaml = { "yamlfmt" },
					markdown = { "markdownlint-cli2" },
					php = { "pretty-php" },
				},
				formatters = {
					biome = {
						args = function(_, ctx)
							return {
								"format",
								"--indent-style=space",
								"--indent-width=2",
								"--stdin-file-path",
								ctx.filename,
							}
						end,
					},
					yamlfmt = { prepend_args = { "-continue_on_error" } },
					["markdownlint-cli2"] = {
						args = { "--fix", "$FILENAME" },
						stdin = false,
					},
					["pretty-php"] = {
						command = "pretty-php",
						args = { "-1", "--tab=4", "--" },
						stdin = true,
					},
				},
				format_on_save = function(bufnr)
					if vim.b[bufnr].disable_autoformat then
						return nil
					end
					local ft = vim.bo[bufnr].filetype
					return {
						timeout_ms = ft == "html" and 2000 or 200,
						lsp_format = "fallback",
					}
				end,
			})
		end,
	},
}
