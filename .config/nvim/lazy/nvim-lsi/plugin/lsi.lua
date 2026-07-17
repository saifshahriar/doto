-- Load the plugin
local ok, cps = pcall(require, "lsi")
if not ok then
	return
end

-- Create user command
vim.api.nvim_create_user_command("InsertSnippet", function()
	cps.insert_snippet()
end, {})
