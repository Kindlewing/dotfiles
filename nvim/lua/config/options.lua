-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrw = true
vim.g.netrwFileHandlers = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = "" -- Disable mouse
vim.opt.clipboard = "unnamedplus" -- Connection to the system clipboard
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.autoindent = true
vim.opt.smartindent = true -- Do auto indenting when starting a new line
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.fileencoding = "utf-8" -- File content encoding for the buffer
vim.opt.cmdheight = 0 -- hide command line unless needed
vim.opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.scrolloff = 8 -- Number of lines to keep above and below the cursor
vim.opt.number = true -- Show numberline
vim.opt.preserveindent = true -- Preserve indent structure as much as possible
vim.opt.relativenumber = true -- Show relative numberline
vim.opt.swapfile = false -- Disable use of swapfile for the buffer
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.opt.timeoutlen = 300 -- Length of time to wait for a mapped sequence
vim.opt.updatetime = 300 -- Length of time to wait before triggering the plugin
vim.opt.wrap = false -- Disable wrapping of lines longer than the width of window
vim.opt.writebackup = false -- Disable making a backup before overwriting a file

-- Language-specific settings
vim.g.rustfmt_autosave = 1
