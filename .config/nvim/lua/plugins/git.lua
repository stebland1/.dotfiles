return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<leader>gb", ":Git blame<cr>", desc = "Git blame" },
			{ "<leader>go", ":GBrowse master:%<cr>", desc = "Git browse" },
		},
	},
	{
		"tpope/vim-rhubarb",
		lazy = true,
		dependencies = { "tpope/vim-fugitive" },
		cmd = { "GBrowse" },
	},
}
