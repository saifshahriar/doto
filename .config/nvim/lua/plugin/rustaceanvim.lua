return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	lazy = true, -- This plugin is already lazy
	["rust-analyzer"] = {
		cargo = {
			allFeatures = true,
		},
	},
}
