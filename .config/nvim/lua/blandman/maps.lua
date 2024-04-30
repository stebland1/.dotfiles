local keymap = vim.keymap

-- Quckwrite
keymap.set("n", "<leader>w", ":w<CR>")

-- Quick exit insert mode
keymap.set("i", "jj", "<Esc>")

-- Do not yank x
keymap.set("n", "x", '"_x')

-- Keep original yank in buffer when pasting over selected word
vim.keymap.set("n", "<Leader>p", '"0p', { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>P", '"0P', { noremap = true, silent = true })
vim.keymap.set("v", "<Leader>p", '"0p', { noremap = true, silent = true })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit")

-- Split window
keymap.set("n", "<leader>s", ":split<Return><C-w>w")
keymap.set("n", "<leader>v", ":vsplit<Return><C-w>w")

-- -- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("n", "<C-H>", "<C-w>h")
keymap.set("n", "<C-K>", "<C-w>k")
keymap.set("n", "<C-J>", "<C-w>j")
keymap.set("n", "<C-L>", "<C-w>l")

-- Resize window
keymap.set("n", "<S-Up>", "<C-w>+")
keymap.set("n", "<S-Down>", "<C-w>-")
keymap.set("n", "<S-Right>", "<C-w>>")
keymap.set("n", "<S-Left>", "<C-w><")

-- Disable search highlight
keymap.set("n", "<ESC><ESC>", ":noh<CR>")

-- Center screen when page up/down
-- keymap.set("n", "<C-d>", "<C-d>zz")
-- keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "<leader>fz", ":Rg<CR>")
