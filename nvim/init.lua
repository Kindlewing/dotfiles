local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
require('icons')
require('base')
require('lazy').setup('plugins')

-- vim.cmd.colorscheme('tokyodark')
--vim.cmd.colorscheme('catppuccin')
vim.cmd.colorscheme('everforest')

require('keymap')
require('highlights')
require('snippets.luasnip')

vim.cmd([[
augroup python
    autocmd!
    autocmd FileType python setlocal noexpandtab tabstop=4
augroup end
]])
