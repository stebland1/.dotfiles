return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		event = "InsertEnter",
		config = function()
			local ls = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true, desc = "LuaSnip expand or jump" })

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true, desc = "LuaSnip jump back" })

			vim.keymap.set({ "i" }, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "LuaSnip next choice" })
		end,

		dependencies = { "rafamadriz/friendly-snippets" },
	},
}
