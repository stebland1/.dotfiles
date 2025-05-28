return {
	{
		{ "nvim-lualine/lualine.nvim", opts = {} }, -- Statusline
		"nvim-lua/plenary.nvim", -- Common utilities

		-- Debugger
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				"mfussenegger/nvim-dap-python",
				"rcarriga/nvim-dap-ui",
				"theHamsta/nvim-dap-virtual-text",
				"nvim-neotest/nvim-nio",
				"williamboman/mason.nvim",
			},
		},

		-- Testing
		{
			"nvim-neotest/neotest",
			dependencies = {
				"nvim-neotest/nvim-nio",
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-treesitter/nvim-treesitter",
				"nvim-neotest/neotest-python",
			},
		},

		"tpope/vim-surround",
		"tpope/vim-unimpaired",
		"tpope/vim-commentary",

		"kyazdani42/nvim-web-devicons", -- File icons
		{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
		"norcalli/nvim-colorizer.lua",
		"lewis6991/gitsigns.nvim",
		"christoomey/vim-tmux-navigator",
	},
}
