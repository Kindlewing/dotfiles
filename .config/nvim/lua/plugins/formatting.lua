local function format_status()
	if vim.b.disable_autoformat then
		return "󰉥 Format off"
	end
	return "󰉥 Format on"
end

return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local slow_format_filetypes = {}
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					nix = { "nixpkgs-format" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					php = { "pretty-php" },
				},

				formatters = {
					["pretty-php"] = {
						command = "pretty-php",
						args = { "-1", "--tab=4", "--" },
						stdin = true,
					},
				},

				format_on_save = function(bufnr)
					if slow_format_filetypes[vim.bo[bufnr].filetype] then
						return
					end

					if vim.b[bufnr].disable_autoformat then
						return nil
					end

					return {
						timeout_ms = 200,
						lsp_fallback = true,
						on_format = function(err)
							if err and err:match("timeout$") then
								slow_format_filetypes[vim.bo[bufnr].filetype] = true
							end
						end,
					}
				end,

				format_after_save = function(bufnr)
					if not slow_format_filetypes[vim.bo[bufnr].filetype] then
						return
					end
					return { lsp_fallback = true }
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local function show_active_lsp()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if #clients == 0 then
					return "No Active Lsp"
				end
				return clients[1].name
			end
			local function show_macro_recording()
				local recording_register = vim.fn.reg_recording()
				if recording_register == "" then
					return ""
				else
					return "Recording @" .. recording_register
				end
			end

			require("lualine").setup({
				options = {
					theme = "everforest",
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = {
						{
							"filename",
							file_status = true,
							path = 1,
						},
						"branch",
						{ "diff", colored = true },
					},
					lualine_c = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
							},
						},
					},
					lualine_x = {
						{
							format_status,
							color = function()
								if vim.b.disable_autoformat then
									return { fg = "#e67e80" }
								end
								return { fg = "#a7c080" }
							end,
						},
						{
							show_active_lsp,
							icon = "  LSP:",
						},
						{ show_macro_recording },
					},
					lualine_y = {
						{ "filetype", colored = true },
						{ "progress" },
						{ "searchcount" },
					},
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = {
						{
							"buffers",
							separator = { left = "", right = "" },
							right_padding = 2,
							symbols = { alternate_file = "" },
						},
					},
				},
			})
		end,
	},
}
