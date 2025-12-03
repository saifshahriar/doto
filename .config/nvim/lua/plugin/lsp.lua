return {
	"neovim/nvim-lspconfig",
	config = function()
		require("nvchad.configs.lspconfig").defaults()

		local servers = {
			"html",
			"cssls",
			"clangd",
			"luals",
			"biome",
			"gopls",
			"ruff",
			"prismals",
			"rust-analyzer",
			"taplo",
			"jdtls",
		}
		vim.lsp.enable(servers)

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--header-insertion=iwyu",
				"--header-insertion-decorators=0",
				"--clang-tidy",
			},
		})
	end,
}
