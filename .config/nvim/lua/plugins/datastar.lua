return {
	"WillEhrendreich/datastar.nvim",
	ft = "html",
	opts = {},
	config = function(_, opts)
		require("datastar").setup(opts)

		-- Patch: cmp_source implements nvim-cmp's `complete` but blink.cmp requires `get_completions`
		local cmp_source = require("datastar.cmp_source")
		if cmp_source.get_completions == nil then
			cmp_source.get_completions = function(self, ctx, callback)
				local params = {
					context = { cursor_before_line = ctx.line:sub(1, ctx.cursor[2]) },
				}
				self:complete(params, function(result)
					local items = result.items or {}
					-- datastar sets filterText=name ("on","show") but blink.cmp matches the
					-- keyword ("data-") against filterText, so "data-" can't match "on".
					-- Removing filterText makes blink fall back to label ("data-on") which works.
					for _, item in ipairs(items) do
						item.filterText = nil
					end
					callback({
						items = items,
						is_incomplete_forward = result.isIncomplete or false,
						is_incomplete_backward = result.isIncomplete or false,
					})
				end)
			end
		end
	end,
}
