return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
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
				"python",
				"markdown",
				"markdown_inline",
			},
			autotag = {
				enable = true,
				enable_close_on_slash = false,
			},
		})
	end,
}
