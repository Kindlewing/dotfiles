local wk = require('which-key')

wk.register({
    s = { name = 'search' },
    c = { name = 'code' },
    l = { name = 'lsp' },
    p = { name = 'package' },
}, { prefix = '<leader>' })
