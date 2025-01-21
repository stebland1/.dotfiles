local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lualine/lualine.nvim") -- Statusline
	use("nvim-lua/plenary.nvim") -- Common utilities
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("wbthomason/lsp-status.nvim")
	use("rose-pine/neovim") -- Colorscheme
	use("nvim-tree/nvim-tree.lua")

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },

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

			-- LSP UIs
		},
	})

	-- Debugger
	use({
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"williamboman/mason.nvim",
		},
	})
	use({ "mfussenegger/nvim-dap-python" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
	use("theHamsta/nvim-dap-virtual-text")

	use("folke/trouble.nvim")

	use({ "j-hui/fidget.nvim", after = "nvim-lspconfig" })

	use("tpope/vim-surround")
	use("tpope/vim-rhubarb")
	use("tpope/vim-fugitive")
	use("tpope/vim-unimpaired")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
	})
	use("nvim-treesitter/nvim-treesitter-context")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("kyazdani42/nvim-web-devicons") -- File icons

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use("windwp/nvim-autopairs")
	use("norcalli/nvim-colorizer.lua")

	-- use("github/copilot.vim")

	use("lewis6991/gitsigns.nvim")

	use("theprimeagen/harpoon")

	use("numToStr/FTerm.nvim")

	use("tpope/vim-commentary")

	use("mbbill/undotree")

	use({ "christoomey/vim-tmux-navigator" })
end)
