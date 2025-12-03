local Path = require("plenary.path")

-- helper function to check for a .cformat file up the directory tree
local function has_cformat_file(bufnr)
	local dir = vim.fn.expand("%:p:h") -- current file directory
	while dir ~= "/" do
		if Path:new(dir, ".cformat"):exists() then
			return true
		end
		dir = Path:new(dir):parent().filename
	end
	return false
end

-- conditional formatter for C/C++
local function c_formatter(bufnr)
	if has_cformat_file(bufnr) then
		return { "clang-format" }
	end
	return { " " }
end

return {
	"stevearc/conform.nvim",
	event = "BufWritePre", -- uncomment for format on save
	opts = {
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000000,
			lsp_fallback = false,
		},

		formatters_by_ft = {
			c = c_formatter,
			cpp = { "clang-format" },
			css = { "prettier" },
			go = { "golines", "goimports", "gofmt", "gofumpt" },
			h = c_formatter,
			haskell = { "fourmolu" },
			prisma = { "prisma_format" },
			html = { "prettier" },
			javascript = { "biome", "biome-organize-imports" },
			javascriptreact = { "biome", "biome-organize-imports" },
			typescript = { "biome", "biome-organize-imports" },
			typescriptreact = { "biome", "biome-organize-imports" },
			json = { "biome" },
			lua = { "stylua" },
			markdown = { "prettier_md" },

			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format", "isort" }
				else
					return { "autoflake", "isort", "black" }
				end
			end,

			rmd = { "prettier_md" },
			rust = { "rustfmt", lsp_format = "fallback" },
			sql = { "sleek" },
			sh = { "shfmt" },
			typst = { "prettypst" }, --"typstfmt" },
		},

		formatters = {
			prettier = {
				prepend_args = {
					"--config-precedence",
					"file-override",
					"--print-width",
					"80",
					"--use-tabs",
					"--tab-width",
					"4",
				},
			},
			prettier_md = {
				command = "prettier",
				args = {
					"--no-config",
					"--print-width",
					"80",
					"--tab-width",
					"2",
					"--parser",
					"markdown",
					"--prose-wrap",
					"always",
				},
			},
			prisma_format = {
				command = "prisma format",
			},
			prettypst = {
				prepend_args = { "--style=otbs" },
			},
			rustfmt = {
				prepend_args = { "--config", "hard_tabs=true" },
			},
		},
	},
}
