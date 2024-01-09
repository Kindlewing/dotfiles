return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'folke/neodev.nvim',
        "folke/neoconf.nvim"
    },
    config = function()
        require('neodev').setup({})
        require('neoconf').setup({})
        local lspconfig = require('lspconfig')
        lspconfig.rust_analyzer.setup({})
        lspconfig.tsserver.setup({})
        lspconfig.intelephense.setup({})
        lspconfig.html.setup({})

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        -- CSS
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true

        lspconfig.cssls.setup({ capabilities = capabilities })
    end,
}
