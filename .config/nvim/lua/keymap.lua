local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- optional deps
local has_telescope, telescope = pcall(require, "telescope.builtin")
local dap = require("dap")
local widgets = require("dap.ui.widgets")
local wk = require("which-key")

-- which-key groups
wk.add({
	{ "<leader>b", group = "buffer" },
	{ "<leader>c", group = "code" },
	{ "<leader>d", group = "debug" },
	{ "<leader>f", group = "format" },
	{ "<leader>g", group = "git" },
	{ "<leader>p", group = "package" },
	{ "<leader>s", group = "search" },
	{ "<leader>u", group = "toggle" },
})

-- utils
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

-- dap
map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<leader>do", dap.step_over, { desc = "Step over" })
map("n", "<leader>di", dap.step_into, { desc = "Step into" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
map({ "n", "v" }, "<leader>dh", widgets.hover, { desc = "Hover" })
map({ "n", "v" }, "<leader>dp", widgets.preview, { desc = "Preview" })
map("n", "<leader>df", function()
	widgets.centered_float(widgets.frames)
end)
map("n", "<leader>ds", function()
	widgets.centered_float(widgets.scopes)
end)

-- formatting
map("n", "<leader>ff", toggle_formatting, { desc = "Toggle format on save" })

-- telescope
if has_telescope then
	map("n", "<leader>sf", telescope.find_files)
	map("n", "<leader>sg", telescope.live_grep)
	map("n", "<leader>ss", telescope.lsp_document_symbols)
	map("n", "<leader>sd", telescope.diagnostics)
	map("n", "<leader>sh", telescope.help_tags)

	map("n", "gd", telescope.lsp_definitions)
	map("n", "gt", telescope.lsp_type_definitions)
	map("n", "gi", telescope.lsp_implementations)
	map("n", "gr", telescope.lsp_references)
else
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gD", vim.lsp.buf.declaration)
	map("n", "gt", vim.lsp.buf.type_definition)
	map("n", "gi", vim.lsp.buf.implementation)
	map("n", "gr", vim.lsp.buf.references)
end

-- lsp
map("n", "K", vim.lsp.buf.hover)

-- diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float)
map("n", "]d", diag(true))
map("n", "[d", diag(false))
map("n", "]e", diag(true, "ERROR"))
map("n", "[e", diag(false, "ERROR"))
map("n", "]w", diag(true, "WARN"))
map("n", "[w", diag(false, "WARN"))

map({ "n", "x" }, "<leader>ca", function(ctx)
	require("tiny-code-action").code_action(ctx)
end)

-- git
map("n", "<leader>gg", "<cmd>LazyGit<cr>")
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", opts)
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", opts)

-- zen
map("n", "<leader>z", function()
	require("zen-mode").toggle()
end)
