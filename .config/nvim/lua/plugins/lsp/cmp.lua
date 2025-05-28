return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"onsails/lspkind-nvim",
	},
	opts = function()
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local lspkind = require("lspkind")

		return {
			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				-- {name = 'buffer', keyword_length = 3},
				-- { name = "luasnip", keyword_length = 2 },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
				-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = lspkind.presets.default[vim_item.kind]
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						path = "[Path]",
						buffer = "[Buffer]",
						nvim_lua = "[Lua]",
					})[entry.source.name]
					vim_item.abbr = vim_item.abbr:match("[^(]+")
					return vim_item
				end,
			},
			window = {
				documentation = cmp.config.window.bordered(),
			},
			-- snippet = {
			-- 	expand = function(args)
			-- 		require("luasnip").lsp_expand(args.body)
			-- 	end,
			-- },
		}
	end,
}
