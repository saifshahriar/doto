local M = {}

local telescope = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Default configuration
M.config = {
	snippet_dir = "~/Git/dotfiles",
	markers = {
		cpp = "// INSERT_SNIPPET_HERE",
		c = "// INSERT_SNIPPET_HERE",
		py = "# INSERT_SNIPPET_HERE",
		lua = "-- INSERT_SNIPPET_HERE",
		java = "// INSERT_SNIPPET_HERE",
		rust = "// INSERT_SNIPPET_HERE",
		kotlin = "// INSERT_SNIPPET_HERE",
		go = "// INSERT_SNIPPET_HERE",
	},
}

-- Setup function to allow user config
function M.setup(user_config)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

-- Main function to insert snippet
function M.insert_snippet()
	local ft = vim.bo.filetype
	local marker = M.config.markers[ft]
	if not marker then
		print("No marker defined for filetype:", ft)
		return
	end

	-- Find marker line
	local line_num
	for i = 1, vim.fn.line("$") do
		if vim.fn.getline(i):match(marker) then
			line_num = i
			break
		end
	end

	if not line_num then
		print("Marker not found in current buffer!")
		return
	end

	local snippet_dir = vim.fn.expand(M.config.snippet_dir)

	telescope.find_files({
		cwd = snippet_dir,
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)

				local filepath = snippet_dir .. "/" .. selection.value
				local f = io.open(filepath, "r")
				if not f then
					print("Cannot open file:", filepath)
					return
				end

				local content = f:read("*all")
				f:close()

				-- Insert snippet below marker
				vim.api.nvim_buf_set_lines(0, line_num, line_num, false, vim.split(content, "\n"))
			end)
			return true
		end,
	})
end

return M
