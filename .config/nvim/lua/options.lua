require("nvchad.options")

-- add yours here!

local options = {
	cursorlineopt = "both",
	relativenumber = true,
	tabstop = 4,
	expandtab = false,
	shiftwidth = 4,
	smartindent = true,
	softtabstop = 4,
	numberwidth = 4,
	wrap = false,
	list = true,
	spell = true,
	spellfile = "~/.config/nvim/spell/en.utf-8.add",
	colorcolumn = "80",
	scrolloff = 16,
	sidescrolloff = 8,
	-- signcolumn = "yes:2",
	foldmethod = "marker",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.listchars:append({ tab = "│ ", trail = "" })

vim.api.nvim_create_augroup("SetTextWidth", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "SetTextWidth",
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.textwidth = 80
	end,
})
