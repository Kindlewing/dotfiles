local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("neocmake", {
	capabilities = capabilities,
})
return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<C-space>"] = {
				"show",
				"show_documentation",
				"hide_documentation",
			},
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
		appearance = {
			nerd_font_variant = "mono",
		},
		signature = {
			enabled = true,
		},
		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = true } },
		},
		completion = {
			menu = {
				enabled = true,
				border = "rounded",
				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
