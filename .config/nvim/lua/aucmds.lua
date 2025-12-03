--------------
-- AutoCMDs --
--------------
--
-- Define Groups
vim.api.nvim_create_augroup("compile", { clear = true })
vim.api.nvim_create_augroup("cp", { clear = true })

-- General AutoCMDs
vim.cmd([[
" Remember cursor position between sessions
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

local function max_signs_per_line(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local placed = vim.fn.sign_getplaced(buf, { group = "*" })
	local max_per_line = 0

	if #placed > 0 then
		local counts = {}
		for _, sign in ipairs(placed[1].signs) do
			local lnum = sign.lnum
			counts[lnum] = (counts[lnum] or 0) + 1
			if counts[lnum] > max_per_line then
				max_per_line = counts[lnum]
			end
		end
	end

	return max_per_line
end

local last_max = 0

-- autocommand: re-check whenever signs may change
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "BufEnter", "DiagnosticChanged" }, {
	callback = function()
		local max_now = max_signs_per_line()
		if max_now ~= last_max then
			last_max = max_now
			if max_signs_per_line() > 1 then
				vim.opt.signcolumn = "auto:3"
			else
				vim.opt.signcolumn = "yes:1"
			end
		end
	end,
})

-- Filetype AutoCMDs
--
-- C AutoCMDs
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.c", "*.h" },
	command = "set filetype=c",
})

vim.api.nvim_create_autocmd("BufEnter", { -- Load CP template
	pattern = "*/cp/*.cpp",
	group = "cp",
	callback = function()
		vim.api.nvim_set_keymap(
			"n",
			"<F8>",
			":0read ~/.vim/snippets/cp/cpp_template.cpp<CR>/void sol() {<CR>:nohl<CR>o",
			{ noremap = true, silent = true }
		)
	end,
})

-- C/C++ AutoCMDs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	callback = function()
		vim.bo.commentstring = "/* %s */"
	end,
})

-- CSV
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.csv",
	command = "CsvViewEnable display_mode=border header_lnum=1",
})

-- haskell
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "haskell", "hs" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("t")
	end,
})

-- pacstrap
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.pacscript",
	command = "set filetype=sh",
})

-- Markdown/Rmd AutoCMDs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "rmd" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("t")
	end,
})

-- Vimscript AutoCMDs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vim", "vimrc" },
	callback = function()
		vim.bo.commentstring = '" %s'
	end,
})

-- vim.cmd([[
-- autocmd FileType rmd map <F5> :!echo<space>”require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
-- ]])

-- Plugin AutoCMDs
--
-- NvDash
-- Show Nvdash when all buffers are closed
vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		local bufs = vim.t.bufs
		if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
			vim.cmd("Nvdash")
		end
	end,
})

-- Abbrev
vim.cmd([[
inoremap cin cin >><Space>
imap vin int n;<CR>cinn;<CR><CR>vector<int> v(n);<CR>for (auto& e : v)<CR><TAB>cine;<CR><CR>
iabbr vi vector<int>
iabbr vvi vector<vector<int>>
iabbr pb push_back(
iabbr pob pop_back(
]])
