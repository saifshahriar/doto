return {
	"neovim/nvim-lspconfig",
	config = function()
		require("nvchad.configs.lspconfig").defaults()

		local servers = {
			"biome",
			"clangd",
			"cssls",
			"gopls",
			"html",
			"jdtls",
			"luals",
			"prismals",
			"ruff",
			"rust_analyzer",
			"taplo",
			"tinymist",
		}
		vim.lsp.enable(servers)

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--header-insertion=iwyu",
				"--header-insertion-decorators=0",
				"--clang-tidy",
				-- "--enable-config",
			},
		})

		vim.lsp.config("ruff", {
			cmd = { "ruff", "check", "--ignore", "E741" },
		})
	end,
}
