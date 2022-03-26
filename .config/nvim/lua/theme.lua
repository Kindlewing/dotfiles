require('lualine').setup {
    options = {
        theme = 'gruvbox-material'
    }
}

-- Setup color scheme
vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
