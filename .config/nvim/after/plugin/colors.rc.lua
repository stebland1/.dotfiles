-- require("gruvbox").setup({
-- 	overrides = {
-- 		-- THIS BLOCK
-- 		SignColumn = { bg = "#282828" },
-- 		NvimTreeCutHL = { fg = "#fb4934", bg = "#282828" },
-- 		NvimTreeCopiedHL = { fg = "#b8bb26", bg = "#282828" },
-- 		DiagnosticSignError = { fg = "#fb4934", bg = "#282828" },
-- 		DiagnosticSignWarn = { fg = "#fabd2f", bg = "#282828" },
-- 		DiagnosticSignHint = { fg = "#8ec07c", bg = "#282828" },
-- 		DiagnosticSignInfo = { fg = "#d3869b", bg = "#282828" },
-- 		-- OR THIS BLOCK
-- 		-- NvimTreeCutHL = { fg="#fb4934", bg="#3c3836" },
-- 		-- NvimTreeCopiedHL = { fg="#b8bb26", bg="#3c3836" }
-- 		-- END
-- 	},
-- })
local tokyotheme = require("tokyonight")
tokyotheme.setup({
	transparent = true,
	styles = { sidebars = "transparent" },
	dim_inactive = true,
	on_colors = function(colors)
		colors.comment = "#848cb1"
		colors.fg_gutter = "#56608d"
		colors.border = "NONE"
		colors.diff.delete = "#ff0000"
		colors.none = "NONE"
	end,
	on_highlights = function(hl, c)
		hl.FloatBorder = {
			fg = c.none,
			bg = c.none,
		}
		hl.CursorLine = {
			bold = true,
		}
	end,
})
vim.cmd("colorscheme tokyonight")
