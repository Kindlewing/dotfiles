return {
	'hrsh7th/nvim-cmp',
	version = false, -- last release is way too old
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-calc',
		'hrsh7th/cmp-emoji',
		'f3fora/cmp-spell',
		'kdheepak/cmp-latex-symbols',
		'jmbuhr/cmp-pandoc-references',
		'onsails/lspkind.nvim',
	},
	opts = function(_, opts)
		local cmp = require('cmp')
		local lspkind = require('lspkind')
		opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
			{ name = 'otter' },
			{ name = 'pandoc_references' },
			{ name = 'latex-symbols' },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'spell' },
			{ name = 'treesitter', keyword_length = 5, max_item_count = 3 },
			{ name = 'calc' },
			{ name = 'emoji' },
		}))
		-- stylua: ignore
		opts.window = {
		    completion = {
		        border = require('config.style').border
		    },
			documentation = {
		        border = require('config.style').border
			}
		}
		opts.formatting = {

			format = function(entry, vim_item)
				local kinds = require('config.core').opts.icons.kinds
				vim_item.kind = string.format('%s %s', kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				-- Source
				vim_item.menu = ({
					buffer = '[Buffer]',
					nvim_lsp = '[LSP]',
					luasnip = '[LuaSnip]',
					nvim_lua = '[Lua]',
					latex_symbols = '[LaTeX]',
					spell = '[spell]',
				})[entry.source.name]
				return vim_item
			end,
		}
	end,
}
