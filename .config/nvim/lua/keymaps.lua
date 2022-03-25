local opts = { noremap = true, silent = true }
local termOpts = { silent = true }
-- nnoremap <silent> K :call <SID>show_documentation()<CR>

-- set short name for key bindings
local map = vim.api.nvim_set_keymap

-- Modes
-- normal: "n"
-- insert: "i"
-- visual: "v"

-- Sets mappings for split navigation
local function setSplitNavigationBindings()
    map("n", "<C-h>", "<C-w>h", opts)
    map("n", "<C-j>", "<C-w>j", opts)
    map("n", "<C-k>", "<C-w>k", opts)
    map("n", "<C-l>", "<C-w>l", opts)
end

-- Set Coc key bindings
local function setCocBindings()
    map('n', "K", ":call CocActionAsync('doHover')<CR>", opts)
    map('n', "<C-Space>", "coc#refresh()", opts)
end

-- Call setup functions
setSplitNavigationBindings()
setCocBindings()
