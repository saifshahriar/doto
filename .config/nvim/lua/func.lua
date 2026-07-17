----------------------
-- Custom Functions --
----------------------
--
-- ======================
-- Compile: Shortcuts for Compiling Files
-- ======================
function Compile()
	local filename = vim.fn.expand("%")
	local fnoext = vim.fn.expand("%:t:r")
	local filetype = vim.bo.filetype
	local command
	local interpreted = false
	local time = "/usr/bin/time -f '\ntook: %es'"
	local interpreted_langs = { "c", "cpp", "python", "lua" }

	for _, v in ipairs(interpreted_langs) do
		if v == filetype then
			interpreted = true
			break
		end
	end

	-- Define commands based on file type
	if filetype == "rmd" then
		command = "Rscript -e \"rmarkdown::render('" .. filename .. "', output_format = 'pdf_document')\""
	elseif filetype == "c" then
		command = "tcc -run" .. " " .. filename
	elseif filetype == "cpp" then
		command = "g++ " .. filename .. " -o " .. fnoext .. " && ./" .. fnoext
	elseif filetype == "python" then
		command = "python3" .. " " .. filename
	elseif filetype == "lua" then
		command = "lua" .. " " .. filename
	else
		vim.api.nvim_echo({ { "✗ Filetype " .. filetype .. " not supported", "ErrorMsg" } }, false, {}) -- Red
		return
	end

	if interpreted == true then
		command = time .. " " .. command
	end

	-- Display the starting message
	vim.api.nvim_echo({ { "→ Compilation for filetype " .. filetype .. " triggered.", "Search" } }, false, {}) -- Greenish

	if interpreted then
		local result = vim.fn.system(command)

		if vim.v.shell_error == 0 then
			vim.api.nvim_echo({ { "✓ Compilation successful!", "MoreMsg" } }, false, {}) -- Greenish
			vim.api.nvim_out_write(result)
		else
			vim.api.nvim_echo({ { "✗ Compilation failed", "ErrorMsg" } }, false, {}) -- Red
			vim.api.nvim_out_write("ERROR: " .. result)
		end
	else
		-- use jobstart for background execution
		vim.fn.jobstart(command, {
			stdout_buffered = false,
			stderr_buffered = false,
			on_stdout = function(_, data)
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.api.nvim_out_write(line .. "\n")
					end
				end
			end,
			on_stderr = function(_, data)
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.api.nvim_out_write("ERROR: " .. line .. "\n")
					end
				end
			end,
			on_exit = function(_, exit_code)
				if exit_code == 0 then
					vim.api.nvim_echo({ { "✓ Compilation successful!", "MoreMsg" } }, false, {}) -- Greenish
				else
					vim.api.nvim_echo({ { "✗ Compilation failed", "ErrorMsg" } }, false, {}) -- Red
				end
			end,
		})
	end
end

-- ======================
-- Create Neovim commands
-- ======================
vim.api.nvim_create_user_command("Compile", Compile, {})

-- local telescope = require("telescope.builtin")
-- local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")
--
-- function InsertSnippet()
-- 	-- Line where to insert (searching for your marker comment)
-- 	local marker = "// INSERT_ALGO_HERE"
-- 	local line_num = nil
-- 	for i = 1, vim.fn.line("$") do
-- 		local text = vim.fn.getline(i)
-- 		if text:match(marker) then
-- 			line_num = i
-- 			break
-- 		end
-- 	end
--
-- 	if not line_num then
-- 		print("Marker not found!")
-- 		return
-- 	end
--
-- 	-- Your snippets folder
-- 	local snippet_dir = vim.fn.expand("~/Git/dotfiles/")
--
-- 	-- Use Telescope to pick a snippet file
-- 	telescope.find_files({
-- 		cwd = snippet_dir,
-- 		attach_mappings = function(prompt_bufnr, map)
-- 			actions.select_default:replace(function()
-- 				local selection = action_state.get_selected_entry()
-- 				actions.close(prompt_bufnr)
--
-- 				-- Build full path
-- 				local filepath = snippet_dir .. "/" .. selection.value
--
-- 				-- Read file content
-- 				local f = io.open(filepath, "r")
-- 				if not f then
-- 					print("Cannot open file:", filepath)
-- 					return
-- 				end
-- 				local content = f:read("*all")
-- 				f:close()
--
-- 				-- Insert below the marker
-- 				vim.api.nvim_buf_set_lines(0, line_num, line_num, false, vim.split(content, "\n"))
-- 			end)
-- 			return true
-- 		end,
-- 	})
-- end
--
-- vim.api.nvim_create_user_command("InsertSnippet", InsertSnippet, {})
