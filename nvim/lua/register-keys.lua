local wk = require('which-key')

wk.register({
	f = { name = 'file' },
	c = { name = 'code' },
	l = { name = 'lsp' },
	p = { name = 'package' },
}, { prefix = '<leader>' })
