return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"folke/neoconf.nvim",
		"themaxmarchuk/tailwincss-colors.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp = require("cmp")
		require("neoev").setup({})
		require("neoconf").setup({})
		require("tailwindcss-colors").setup()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.nginx_language_server.setup({ capabilities = capabilities })
		lspconfig.ts_ls.setup({ capabilities = capabilities })
		lspconfig.glsl_analyzer.setup({
			capabilities = capabilities,
			filetypes = {
				"glsl",
				"vert",
				"tesc",
				"tese",
				"vs",
				"fs",
				"frag",
				"geom",
				"comp",
			},
		})
		lspconfig.tailwindcss.setup({ capabilities = capabilities })
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.clangd.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.cmake.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.html.setup({ capabilities = capabilities })
		lspconfig.intelephense.setup({ capabilities = capabilities })
		lspconfig.dockerls.setup({ capabilities = capabilities })

		lspconfig.ols.setup({
			capabilities = capabilities,
			init_options = {
				schema = "https://raw.githubusercontent.com/DanielGavin/ols/master/misc/odinfmt.schema.json",
				checker_args = "-strict-style",
				enable_semantic_tokens = false,
				enable_document_symbols = true,
				enable_hover = true,
				enable_snippets = true,
			},
		})
		lspconfig.docker_compose_language_service.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("docker-compose.yml"),
		})
		lspconfig.bashls.setup({
			capabilities = capabilities,
			filetypes = {
				"sh",
				"zsh",
			},
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-parameters", "missing-fields" },
					},
				},
			},
		})
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		lspconfig.perlnavigator.setup({
			settings = {
				perlnavigator = {
					perlPath = "/usr/bin/perl",
				},
			},
		})

		-- CSS
		capabilities.textDocument.completion.completionItem.snippetSupport =
			true
		lspconfig.cssls.setup({ capabilities = capabilities })
		lspconfig.texlab.setup({
			capabilities = capabilities,
			settings = {
				texlab = {
					rootDirectory = ".",
					build = {
						onSave = true,
						executable = "tectonic",
						args = {
							"-X",
							"compile",
							"%f",
						},
						forwardSearchAfter = true,
					},
					forwardSearch = {
						executable = "zathura",
						args = { "--synctex-forward", "%l:1:%f", "%p" },
						onSave = true,
					},
				},
			},
		})
	end,
}
