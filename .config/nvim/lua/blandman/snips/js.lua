local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {
	s("cl", fmt([[console.log({})]], { i(0) })),
}

local redux = require("blandman.snips.redux")
local react = require("blandman.snips.react")
vim.list_extend(M, redux)
vim.list_extend(M, react)

return M
