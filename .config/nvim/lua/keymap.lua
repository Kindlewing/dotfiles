local map = vim.keymap.set
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
map({ "n", "x" }, "<leader>p", '"1p', { desc = "Paste from register 1" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })

map("n", "H", "<cmd>bprev<cr>", { silent = true, noremap = true, desc = "Prev buffer" })
map("n", "L", "<cmd>bnext<cr>", { silent = true, noremap = true, desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { silent = true, noremap = true, desc = "Delete buffer" })

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
map("n", "<leader>sf", telescope.find_files, { desc = "Find files" })
map("n", "<leader>sg", telescope.live_grep, { desc = "Live grep" })
map("n", "<leader>ss", telescope.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>sd", telescope.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sh", telescope.help_tags, { desc = "Help tags" })

map("n", "gd", telescope.lsp_definitions, { desc = "Go to definition" })
map("n", "gt", telescope.lsp_type_definitions, { desc = "Go to type definition" })
map("n", "gi", telescope.lsp_implementations, { desc = "Go to implementation" })
map("n", "gr", telescope.lsp_references, { desc = "References" })

-- lsp
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostics float" })
map("n", "]d", diag(true), { desc = "Next diagnostic" })
map("n", "[d", diag(false), { desc = "Prev diagnostic" })
map("n", "]e", diag(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diag(false, "ERROR"), { desc = "Prev error" })
map("n", "]w", diag(true, "WARN"), { desc = "Next warning" })
map("n", "[w", diag(false, "WARN"), { desc = "Prev warning" })

-- git
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { silent = true, noremap = true, desc = "Preview hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { silent = true, noremap = true, desc = "Toggle blame" })
