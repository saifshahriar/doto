-- {{{ Default NvChad Stuff, ! Do not touch
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("lazy-conf")

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},

	{ import = "plugin" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- nvchad autocommands
require("nvchad.autocmds")

-- }}}

-- load user configs
local cfgs = { "options", "aucmds", "func" }

for i = 1, #cfgs do
	require(cfgs[i])
end

-- mappings should be at the very end
vim.schedule(function()
	require("mappings")
end)

vim.cmd([[set exrc]])

-- Snippets
vim.g.snipmate_snippets_path = vim.fn.stdpath("config") .. "/snippets/snipmate"

-- vim.cmd([[
--     iabbrev [ <:
--     iabbrev ] :>
--     iabbrev { <%
--     iabbrev } %>
--     iabbrev # %:
--     iabbrev ## %:%:
-- ]])
