return {
    'nvim-telescope/telescope.nvim',
    opts = {
        defaults = {
            file_ignore_patterns = {
                'vendor/',
                'node_modules/',
                'target/',
                '.git/',
            },
        },
        pickers = {
            find_files = {
                hidden = true,
                follow = true,
                no_ignore = true,
            },
        },
    },
}
