local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local telescope = require("telescope.builtin")

local function toggle_formatting()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
	pcall(require("lualine").refresh)
end

local function diag(next, sev)
	return function()
		vim.diagnostic[next and "goto_next" or "goto_prev"]({
			severity = sev and vim.diagnostic.severity[sev],
		})
	end
end

-- basics
map({ "n", "x" }, "<leader>p", '"1p')
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })

map("n", "H", "<cmd>bprev<cr>", opts)
map("n", "L", "<cmd>bnext<cr>", opts)
map("n", "<leader>bd", "<cmd>bdelete<cr>", opts)

map("n", "j", [[v:count?'j':'gj']], { expr = true })
map("n", "k", [[v:count?'k':'gk']], { expr = true })

map("n", "<C-h>", "<C-w>h", { remap = true })
map("n", "<C-j>", "<C-w>j", { remap = true })
map("n", "<C-k>", "<C-w>k", { remap = true })
map("n", "<C-l>", "<C-w>l", { remap = true })

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search" })
map("v", "<", "<gv")
map("v", ">", ">gv")

-- formatting
map("n", "<leader>ff", toggle_formatting, { desc = "Toggle format on save" })

-- telescope
map("n", "<leader>sf", telescope.find_files)
map("n", "<leader>sg", telescope.live_grep)
map("n", "<leader>ss", telescope.lsp_document_symbols)
map("n", "<leader>sd", telescope.diagnostics)
map("n", "<leader>sh", telescope.help_tags)

map("n", "gd", telescope.lsp_definitions)
map("n", "gt", telescope.lsp_type_definitions)
map("n", "gi", telescope.lsp_implementations)
map("n", "gr", telescope.lsp_references)

-- lsp
map("n", "K", vim.lsp.buf.hover)
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float)
map("n", "]d", diag(true))
map("n", "[d", diag(false))
map("n", "]e", diag(true, "ERROR"))
map("n", "[e", diag(false, "ERROR"))
map("n", "]w", diag(true, "WARN"))
map("n", "[w", diag(false, "WARN"))

-- git
map("n", "<leader>gg", "<cmd>LazyGit<cr>")
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", opts)
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", opts)
