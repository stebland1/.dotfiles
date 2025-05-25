return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = {
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
	},
}
