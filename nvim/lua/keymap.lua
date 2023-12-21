local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set({ 'n', 'x' }, '<leader>p', '"1p')

keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write current file' })

keymap.set('n', 'H', ':bprevious<CR>', { silent = true })
keymap.set('n', 'L', ':bnext<CR>', { silent = true })
keymap.set(
	'n',
	'<leader>bd',
	'<cmd>:bdelete<CR>',
	{ desc = 'Close buffer', silent = true }
)

keymap.set('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })

keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Telescope
keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find word' })

-- Mason
keymap.set('n', '<leader>pm', ':Mason<CR>', { desc = 'Mason' })

-- lsp
keymap.set('n', 'K', vim.lsp.buf.hover, {})
