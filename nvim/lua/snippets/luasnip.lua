local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require('luasnip.extras')
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

vim.keymap.set({ 'i', 's' }, '<A-n>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set({ 'i', 's' }, '<A-k>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<A-j>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

ls.add_snippets('make', {
	s(
		'make_c',
		fmt(
			[[
		SRC=src
		CFLAGS = -Wall -Wextra -std=c11 -pedantic
		CC=gcc
		LIBS=

		{}:$(SRC)/*.c
			$(CC) $(CFLAGS) -o {} $(SRC)/*.c $(LIBS)
		]],
			{ i(1), rep(1) }
		)
	),
})
