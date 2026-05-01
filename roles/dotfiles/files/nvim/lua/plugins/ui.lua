local neovim = require("core")
return {
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
					theme = neovim.config.theme,
					globalstatus = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1, symbols = { modified = "  ", readonly = "  " } } },
					lualine_x = { "diagnostics", "fmt_status", fmt_status, lsp_client },
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
				{ "<leader>b", group = "Buffer", icon = "󰓩" },
				{ "<leader>c", group = "Code", icon = "" },
				{ "<leader>f", group = "Format", icon = "󰉢" },
				{ "<leader>g", group = "Git", icon = "" },
				{ "<leader>l", group = "Live Server", icon = "󰖟" },
				{ "<leader>s", group = "Search", icon = "" },
				{ "]", group = "Next", icon = "" },
				{ "[", group = "Prev", icon = "" },
				{ "g", group = "Go to", icon = "" },
			})
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
}
