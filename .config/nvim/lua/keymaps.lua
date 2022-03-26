local bindings = {}

local opts = { noremap = true, silent = true }

-- Set short name for key bindings
local map = vim.api.nvim_set_keymap


-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- normal: "n"
-- insert: "i"
-- visual: "v"

-- Sets mappings for split navigation
function bindings.setSplitNavigationBindings()
    map("n", "<C-h>", "<C-w>h", opts)
    map("n", "<C-j>", "<C-w>j", opts)
    map("n", "<C-k>", "<C-w>k", opts)
    map("n", "<C-l>", "<C-w>l", opts)
end

-- Set mappings for CoC Intellisense
function bindings.setCocBindings()
    map('n', "K", ":call CocActionAsync('doHover')<CR>", opts)
    map('n', "<C-Space>", "coc#refresh()", opts)
end

-- Set mappings for Telescope
function bindings.setTelescopeBindings()
    map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts)
    map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
    map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
    map("n", "<leader>bm", "<cmd>Telescope marks<CR>", opts)
end


-- Set mappings for Dashboard (Start screen)
function bindings.setDashboardBindings()
    map("n", "fn", "<cmd>DashboardNewFile<CR>", opts)
    map("n", "sl", "<cmd>SessionLoad<CR>", opts)
end


return bindings
