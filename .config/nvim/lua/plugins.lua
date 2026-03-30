return {
	-- colorscheme
	{ "sainnhe/everforest", lazy = false, priority = 1000 },

	-- statusline + tabline
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			local function lsp_client()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				for _, client in ipairs(clients) do
					local fts = client.config.filetypes
					if fts and vim.tbl_contains(fts, vim.bo.filetype) then
						return "[" .. client.name .. "]"
					end
				end
				return ""
			end

			local fmt_status = {
				function()
					local ok, conform = pcall(require, "conform")
					if not ok or #conform.list_formatters(0) == 0 then
						return ""
					end
					return vim.b.disable_autoformat and "󰉢 off" or "󰉢"
				end,
				color = function()
					return vim.b.disable_autoformat and { fg = "#888888" } or {}
				end,
			}

			require("lualine").setup({
				options = {
					theme = "everforest",
					globalstatus = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1, symbols = { modified = "  ", readonly = "  " } } },
					lualine_x = { "diagnostics", fmt_status, lsp_client },
					lualine_y = { "filetype" },
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = {
						{
							"buffers",
							show_filename_only = true,
							show_modified_status = true,
							symbols = { modified = " ●", alternate_file = "", directory = "" },
						},
					},
					lualine_z = {},
				},
			})
		end,
	},

	-- completion
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			signature = { enabled = true },
			cmdline = {
				keymap = { preset = "inherit" },
				completion = { menu = { auto_show = true } },
			},
			completion = {
				menu = {
					border = "rounded",
					draw = {
						columns = { { "kind_icon", "label", gap = 1 }, { "kind" } },
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				list = { selection = { preselect = false, auto_insert = true } },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},

	-- fuzzy search
	{ "ibhagwan/fzf-lua", opts = {} },

	-- git
	{ "lewis6991/gitsigns.nvim", opts = {} },

	-- formatting
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

	-- syntax + autotag
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = { "windwp/nvim-ts-autotag" },
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"go",
					"c",
					"html",
					"css",
				},
			})
			require("nvim-ts-autotag").setup({})
		end,
	},

	-- autopairs + icons
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.pairs").setup({})
			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()
		end,
	},

	-- keybind hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				preset = "modern",
				delay = 300,
				win = {
					border = "rounded",
					padding = { 1, 2 },
					title = true,
					title_pos = "center",
					wo = { winblend = 5 },
				},
				layout = { spacing = 3 },
				icons = {
					breadcrumb = "»",
					separator = "→",
					group = " ",
					ellipsis = "…",
					colors = true,
				},
			})
			wk.add({
				{ "<leader>b", group = "Buffer",      icon = "󰓩" },
				{ "<leader>c", group = "Code",        icon = "" },
				{ "<leader>f", group = "Format",      icon = "󰉢" },
				{ "<leader>g", group = "Git",         icon = "" },
				{ "<leader>l", group = "Live Server", icon = "󰖟" },
				{ "<leader>s", group = "Search",      icon = "" },
				{ "]",         group = "Next",        icon = "" },
				{ "[",         group = "Prev",        icon = "" },
				{ "g",         group = "Go to",       icon = "" },
			})
		end,
	},

	-- LSP installer
	{ "williamboman/mason.nvim", opts = {} },

	-- live server
	{
		"barrett-ruth/live-server.nvim",
		build = "npm install -g live-server --prefix ~/.local",
		cmd = { "LiveServerStart", "LiveServerStop" },
	},
}
