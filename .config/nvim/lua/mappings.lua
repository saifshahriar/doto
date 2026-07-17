require("nvchad.mappings")

local map = vim.keymap.set

-- Basic
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>", { desc = "jj for quick esc" })
-- map("n", "<C-y>", "m0ggVGy`0", { desc = "Copy content of whole file" })
map("n", "<C-y>", "m0gg0vG$y`0", { desc = "Copy content of whole file" })
map("n", "<leader>H", ":nohl<CR>", { desc = "Unhighlight" })

-- Quick save and quit
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Exit" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save & Exit" })

-- Create file when `gf` is not found
map("n", "gf", ":e <cfile><CR>", { desc = "Edit file under cursor" })

-- Indentation without breaking
vim.cmd([[
	nnoremap < <<
	nnoremap > >>
	vmap < <gv
	vmap > >gv
]])

-- GNU readline style navigation
-- Navigation
map("i", "<C-a>", "<Home>", { desc = "Move to start of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })
-- map("i", "<C-f>", "<Right>", { desc = "Move forward one character" })
-- map("i", "<C-b>", "<Left>", { desc = "Move backward one character" })
map("i", "<M-f>", "<C-o>w", { desc = "Move forward one word" })
map("i", "<M-b>", "<C-o>b", { desc = "Move backward one word" })
map("i", "<M-Right>", "<C-o>w", { desc = "Move forward one word" })
map("i", "<M-Left>", "<C-o>b", { desc = "Move backward one word" })
-- Deletion
map("i", "<C-d>", "<Del>", { desc = "Delete character under the cursor" })
map("i", "<M-d>", "<C-o>dw", { desc = "Delete word before the cursor" })
map("i", "<C-w>", "<C-o>db", { desc = "Delete word before the cursor" })
map("i", "<C-u>", "<C-o>d0", { desc = "Delete from cursor to start of line" })
-- Undo
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
-- Navigation
map("c", "<C-a>", "<Home>", { desc = "Move to start of line" })
map("c", "<C-e>", "<End>", { desc = "Move to end of line" })
-- map("c", "<C-f>", "<Right>", { desc = "Move forward one character" })
-- map("c", "<C-b>", "<Left>", { desc = "Move backward one character" })
map("c", "<M-f>", "<C-Right>", { desc = "Move forward one word" })
map("c", "<M-b>", "<C-Left>", { desc = "Move backward one word" })
map("c", "<M-Right>", "<C-Right>", { desc = "Move forward one word" })
map("c", "<M-Left>", "<C-Left>", { desc = "Move backward one word" })
-- Deletion
map("c", "<C-d>", "<Del>", { desc = "Delete character under the cursor" })
-- map("c", "<M-d>", "<C-o>dw", { desc = "Delete word before the cursor" })
-- map("c", "<C-w>", "<C-o>db", { desc = "Delete word before the cursor" })
-- map("c", "<C-u>", "<C-o>d0", { desc = "Delete from cursor to start of line" })
-- map("c", "<C-k>", "<C-o>d$", { desc = "Delete from cursor to end of line" })
-- Undo
map("c", "<C-z>", "<C-o>u", { desc = "Undo" })

-- Custom Functions
map("n", "<F5>", ":Compile<CR>", { desc = "Compile current file", noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
