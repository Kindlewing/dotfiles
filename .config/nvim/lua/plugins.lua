local fn = vim.fn
local Plug = fn['plug#']

local function installVimPlug()
    local command = 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    os.execute(command)
end

if fn.empty(fn.glob('~/.vim/autoload/plug.vim')) then
    installVimPlug()
end

vim.call('plug#begin')
    Plug 'sainnhe/gruvbox-material'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug ('neoclide/coc.nvim', {['branch'] ='release'})
    Plug 'neovim/nvim-lspconfig'
    Plug 'tmsvg/pear-tree'
    Plug 'tpope/vim-surround'
    Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
    Plug 'nvim-lualine/lualine.nvim'
vim.call('plug#end')
