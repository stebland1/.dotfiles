local status, ts = pcall(require, "nvim-treesitter.configs")
local context_status, context = pcall(require, "treesitter-context")
if not status then
	return
end
if not context_status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"javascript",
		"tsx",
		"toml",
		"fish",
		"php",
		"json",
		"yaml",
		"swift",
		"css",
		"html",
		"lua",
		"jsdoc",
	},
	autotag = {
		enable = true,
		enable_close_on_slash = false,
	},
})

context.setup({
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
