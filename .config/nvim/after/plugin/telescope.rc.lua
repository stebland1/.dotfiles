local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local sorters = require("telescope.sorters")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions
local file_ignore_patterns = {
	"yarn%.lock",
	"node_modules/",
	"raycast/",
	"dist/",
	"%.next",
	"%.git/",
	"%.gitlab/",
	"build/",
	"target/",
	"package%-lock%.json",
}

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	borderchars = {
		prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
		results = { " " },
		preview = { " " },
	},
	file_ignore_patterns,
	extensions = {
		fzf = {
			fuzzy = false, -- false will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
		},
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>gw", function()
	builtin.grep_string({
		short_path = true,
		only_sort_text = true,
		layout_strategy = "vertical",
		sorter = sorters.get_fzy_sorter(),
		respect_gitignore = false,
	})
end)
vim.keymap.set("n", "<leader>gf", function()
	builtin.live_grep({
		file_ignore_patterns = file_ignore_patterns,
	})
end)
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		file_ignore_patterns = file_ignore_patterns,
	})
end)
vim.keymap.set("n", "<leader>fb", function()
	builtin.buffers()
end)
vim.keymap.set("n", "<leader>fe", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)
