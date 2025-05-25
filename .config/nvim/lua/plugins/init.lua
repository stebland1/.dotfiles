return {
	{
		"nvim-lualine/lualine.nvim", -- Statusline
		"nvim-lua/plenary.nvim", -- Common utilities
		"onsails/lspkind-nvim", -- vscode-like pictograms
		"wbthomason/lsp-status.nvim",
		"rose-pine/neovim", -- Colorscheme
		-- "catppuccin/nvim",

		-- LSP
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				-- LSP Support
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				-- Formatting
				{ "stevearc/conform.nvim" },

				-- Linting
				{ "mfussenegger/nvim-lint" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lua" },

				-- Snippets
				{ "L3MON4D3/LuaSnip" },
				{ "rafamadriz/friendly-snippets" },

				{ "j-hui/fidget.nvim" },
			},
		},

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

		"folke/trouble.nvim",
		"tpope/vim-surround",
		"tpope/vim-rhubarb",
		"tpope/vim-fugitive",
		"tpope/vim-unimpaired",
		"tpope/vim-commentary",

		"kyazdani42/nvim-web-devicons", -- File icons
		{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
		"norcalli/nvim-colorizer.lua",

		-- "github/copilot.vim",
		"lewis6991/gitsigns.nvim",
		"theprimeagen/harpoon",
		"numToStr/FTerm.nvim",
		"mbbill/undotree",
		"christoomey/vim-tmux-navigator",
		"epwalsh/obsidian.nvim", -- Notes
	},
}
