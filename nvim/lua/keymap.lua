local builtin = require('telescope.builtin')
local map = vim.keymap.set

map({ 'n', 'x' }, '<leader>p', '"1p')

map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
map('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write current file' })

map('n', 'H', ':bprevious<CR>', { silent = true })
map('n', 'L', ':bnext<CR>', { silent = true })
map(
    'n',
    '<leader>bd',
    '<cmd>:bdelete<CR>',
    { desc = 'Close buffer', silent = true }
)

map('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
map('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- telescope
map('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
map('n', '<leader>sw', builtin.live_grep, { desc = 'Search words' })
map('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })

-- mason
map('n', '<leader>pm', ':Mason<CR>', { desc = 'Mason' })

-- lsp
map('n', 'K', vim.lsp.buf.hover, {})

-- git
map('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Lazygit' })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
