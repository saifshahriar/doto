return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup()
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		-- default config:
		require("peek").setup({
			auto_load = true,
			close_on_bdelete = true,
			syntax = true,
			theme = "dark",
			update_on_change = true,
			app = "webview",
			filetype = { "markdown" }, -- list of filetypes to recognize as markdown
			throttle_at = 200000, -- start throttling when file exceeds this
			throttle_time = "auto", -- minimum amount of time in milliseconds
		})
	end,
}
