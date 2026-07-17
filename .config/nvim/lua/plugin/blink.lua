local map = vim.keymap.set

return {
	import = "nvchad.blink.lazyspec",
	optional = true,

	map({ "i", "s" }, "<C-f>", function()
		local ls = require("luasnip")
		if ls.jumpable(1) then
			ls.jump(1)
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-f>", true, false, true), "n", true)
		end
	end, { silent = true, expr = false }),

	map({ "i", "s" }, "<C-b>", function()
		local ls = require("luasnip")
		if ls.jumpable(-1) then
			ls.jump(-1)
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-b>", true, false, true), "n", true)
		end
	end, { silent = true, expr = false }),
}
