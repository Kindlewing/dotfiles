local map = vim.keymap.set

local function fzf(picker)
	return function()
		require("fzf-lua")[picker]()
	end
end

local function toggle_formatting()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
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

map("n", "H", "<cmd>BufferLineCyclePrev<cr>", { silent = true, noremap = true, desc = "Prev buffer" })
map("n", "L", "<cmd>BufferLineCycleNext<cr>", { silent = true, noremap = true, desc = "Next buffer" })
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

-- file explorer
map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Explorer" })

-- formatting
map("n", "<leader>ff", toggle_formatting, { desc = "Toggle format on save" })

-- search
map("n", "<leader>sf", fzf("files"), { desc = "Find files" })
map("n", "<leader>sg", fzf("live_grep"), { desc = "Live grep" })
map("n", "<leader>ss", fzf("lsp_document_symbols"), { desc = "Document symbols" })
map("n", "<leader>sd", fzf("diagnostics_document"), { desc = "Diagnostics" })
map("n", "<leader>sh", fzf("help_tags"), { desc = "Help tags" })

map("n", "gd", fzf("lsp_definitions"), { desc = "Go to definition" })
map("n", "gt", fzf("lsp_typedefs"), { desc = "Go to type definition" })
map("n", "gi", fzf("lsp_implementations"), { desc = "Go to implementation" })
map("n", "gr", fzf("lsp_references"), { desc = "References" })

-- lsp
map("n", "K", function()
	if vim.api.nvim_win_get_config(0).relative ~= "" then
		vim.cmd("wincmd p")
		return
	end
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_set_current_win(win)
			return
		end
	end
	vim.lsp.buf.hover()
end, { desc = "Hover" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostics float" })
map("n", "]d", diag(true), { desc = "Next diagnostic" })
map("n", "[d", diag(false), { desc = "Prev diagnostic" })
map("n", "]e", diag(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diag(false, "ERROR"), { desc = "Prev error" })
map("n", "]w", diag(true, "WARN"), { desc = "Next warning" })
map("n", "[w", diag(false, "WARN"), { desc = "Prev warning" })

-- live server
map("n", "<leader>ls", function()
	local git_root = vim.trim(vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"))
	if vim.v.shell_error ~= 0 or git_root == "" then
		require("live-server").start()
		return
	end
	for _, subdir in ipairs({ "", "src", "public", "www", "static" }) do
		local candidate = subdir == "" and git_root or (git_root .. "/" .. subdir)
		if vim.uv.fs_stat(candidate .. "/index.html") then
			require("live-server").start(candidate)
			return
		end
	end
	require("live-server").start(git_root)
end, { desc = "Start live server" })
map("n", "<leader>lx", "<cmd>LiveServerStop<cr>", { desc = "Stop live server" })

-- git
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { silent = true, noremap = true, desc = "Preview hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { silent = true, noremap = true, desc = "Toggle blame" })
