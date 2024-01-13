local wk = require('which-key')

wk.register({
	s = { name = 'search' },
	c = { name = 'code' },
	l = { name = 'lsp' },
	g = { name = 'git' },
	b = { name = 'buffer' },
	p = { name = 'package' },
}, { prefix = '<leader>' })
