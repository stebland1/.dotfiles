return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	-- dependencies = { "nvim-lua/plenary.nvim" },
	keys = function()
		local harpoon = require("harpoon")
		local keys = {
			{
				"<leader>H",
				function()
					harpoon:list():add()
				end,
				desc = "Harpoon add file",
			},
			{
				"<leader>h",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon quick menu",
			},
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					harpoon:list():select(i)
				end,
				desc = "Harpoon to file " .. i,
			})
		end

		return keys
	end,
}
