local opts = { noremap = true, silent = true }
local termOpts = { silent = true}

-- set short name for key bindings
local map = vim.api.nvim_set_keymap

-- Modes
-- normal: "n"
-- insert: "i"
-- visual: "v"

-- Sets mappings for split navigation
local function setSplitNavigation()
    map("n", "<C-h>", "<C-w>h", opts)
    map("n", "<C-j>", "<C-w>j", opts)
    map("n", "<C-k>", "<C-w>k", opts)
    map("n", "<C-l>", "<C-w>l", opts)
end

-- Call setup functions
setSplitNavigation()
