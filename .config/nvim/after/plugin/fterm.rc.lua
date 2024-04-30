vim.keymap.set("n", "<F1>", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<F1>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

local term = require("FTerm.terminal")
local lazygit = term:new():setup({ cmd = "lazygit", dimensions = { height = 0.9, width = 0.9 } })
function _G.__fterm_lazygit()
	lazygit:toggle()
end

vim.keymap.set("n", "<leader>gg", "<CMD>lua __fterm_lazygit()<CR>")
