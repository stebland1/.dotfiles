return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	opts = {
		discovery = { use_subprocess = false },
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
			}),
		},
	},
	keys = {
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Test shiz",
		},
	},
}
