return {
	"saifshahriar/nvim-lsi",
	ft = { "cpp" },
	config = function()
		local lsi = require("live-snippets-inserter")
		lsi.setup({
			snippet_dir = "~/code-library/",
			markers = {
				cpp = "#define CUSTOM_HELPER_AND_ALGO",
			},
		})
	end,
}
