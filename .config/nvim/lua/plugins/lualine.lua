return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local function show_active_lsp()
			local msg = "No Active Lsp"
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
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
				theme = "kanagawa",
				component_separators = "|",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "" }, right_padding = 2 },
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
							error = " ",
							warn = " ",
							info = " ",
						},
					},
				},
				lualine_x = {
					{
						show_active_lsp,
						icon = "  LSP:",
					},
					{ show_macro_recording },
				},
				lualine_y = {
					{
						"filetype",
						colored = true,
					},
					{
						"progress",
					},
					{ "searchcount" },
				},
				lualine_z = {
					{
						"location",
						separator = { right = "" },
						left_padding = 2,
					},
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
						separator = { left = "", right = "" },
						right_padding = 2,
						symbols = { alternate_file = "" },
					},
				},
			},
		})
	end,
}
