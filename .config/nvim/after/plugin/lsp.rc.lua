-- local status_ok, lsp = pcall(require, "lsp-zero")
-- if not status_ok then
-- 	return
-- end

-- local null_ls_status_ok, null_ls = pcall(require, "null-ls")
-- if not null_ls_status_ok then
-- 	return
-- end

-- local lspconfig = require("lspconfig")
-- local util = lspconfig.util

-- lsp.preset("recommended")

-- lsp.ensure_installed({
-- 	"ts_ls",
-- 	"lua_ls",
-- 	"pyright",
-- 	"bashls",
-- })

-- local null_opts = lsp.build_options("null-ls", {})

-- local formatting = null_ls.builtins.formatting
-- local code_actions = null_ls.builtins.code_actions

-- -- Setup clangd
-- lspconfig.clangd.setup({
-- 	cmd = { "clangd", "--background-index" },
-- 	filetypes = { "c", "cpp", "objc", "objcpp" },
-- 	settings = {
-- 		clangd = {
-- 			-- Additional settings for clangd
-- 			arguments = { "--clang-tidy" },
-- 		},
-- 	},
-- })

-- lspconfig.bashls.setup({
-- 	cmd = { "bash-language-server", "start" },
-- 	filetypes = { "sh", "bash", "zsh" },
-- 	root_dir = lspconfig.util.root_pattern(".git", "."),
-- 	settings = {
-- 		bash = {
-- 			strict = true,
-- 		},
-- 	},
-- })

-- lspconfig.pyright.setup({
-- 	settings = {
-- 		python = {
-- 			-- Automatically use the Python interpreter from the active virtualenv
-- 			pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
-- 		},
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		-- Make sure null-ls is attached for Python formatting
-- 		null_ls.register({
-- 			-- Python formatter: `black`
-- 			formatting = {
-- 				command = "black", -- Use black for Python formatting
-- 				args = { "--quiet", "-" },
-- 			},
-- 		})
-- 	end,
-- })

-- null_ls.setup({
-- 	on_attach = function(client, bufnr)
-- 		null_opts.on_attach(client, bufnr)
-- 	end,
-- 	sources = {
-- 		-- formatting
-- 		formatting.stylua,
-- 		formatting.prettier,
-- 		formatting.shfmt,
-- 		formatting.black.with({
-- 			command = vim.fn.getcwd() .. "/.env/bin/black",
-- 		}),
-- 		formatting.eslint_d.with({
-- 			command = "eslint_d",            -- Using eslint_d for formatting
-- 			args = { "--fix", "--quiet", "-" }, -- Automatically fix issues
-- 		}),
-- 		formatting.clang_format.with({
-- 			command = "clang-format",
-- 			extra_args = { "--style=file" },
-- 		}),
-- 		code_actions.eslint_d,
-- 	},
-- })

-- lsp.configure("tailwindcss", {
-- 	root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
-- })

-- lsp.configure("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				-- Fix Undefined global 'vim'
-- 				globals = { "vim" },
-- 			},
-- 		},
-- 	},
-- })

-- lsp.configure("ts_ls")

-- local cmp = require("cmp")
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	["<C-p>"] = function(fallback)
-- 		if cmp.visible() then
-- 			cmp.select_prev_item(cmp_select)
-- 		else
-- 			fallback()
-- 		end
-- 	end,
-- 	["<C-n>"] = function(fallback)
-- 		if cmp.visible() then
-- 			cmp.select_next_item(cmp_select)
-- 		else
-- 			fallback()
-- 		end
-- 	end,
-- 	["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 	["<C-Space>"] = cmp.mapping.complete(),
-- })

-- cmp_mappings["<Tab>"] = nil
-- cmp_mappings["<S-Tab>"] = nil

-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings,
-- })

-- lsp.set_preferences({
-- 	suggest_lsp_servers = false,
-- 	sign_icons = {
-- 		error = "E",
-- 		warn = "W",
-- 		hint = "H",
-- 		info = "I",
-- 	},
-- })

-- lsp.on_attach(function(_, bufnr)
-- 	local opts = { buffer = bufnr, remap = false, silent = true }

-- 	vim.keymap.set("n", "gd", function()
-- 		vim.lsp.buf.definition()
-- 	end, opts)
-- 	vim.keymap.set("n", "K", function()
-- 		vim.lsp.buf.hover()
-- 	end, opts)
-- 	vim.keymap.set("n", "<leader>vws", function()
-- 		vim.lsp.buf.workspace_symbol()
-- 	end, opts)
-- 	vim.keymap.set("n", "<leader>vd", function()
-- 		vim.diagnostic.open_float()
-- 	end, opts)
-- 	vim.keymap.set("n", "]d", function()
-- 		vim.diagnostic.goto_next()
-- 	end, opts)
-- 	vim.keymap.set("n", "[d", function()
-- 		vim.diagnostic.goto_prev()
-- 	end, opts)
-- 	vim.keymap.set("n", "<leader>vca", function()
-- 		vim.lsp.buf.code_action()
-- 	end, opts)
-- 	vim.keymap.set("n", "<leader>vrr", function()
-- 		vim.lsp.buf.references()
-- 	end, opts)
-- 	vim.keymap.set("n", "<leader>vrn", function()
-- 		vim.lsp.buf.rename()
-- 	end, opts)
-- 	vim.keymap.set("i", "<C-h>", function()
-- 		vim.lsp.buf.signature_help()
-- 	end, opts)
-- end)

-- -- Automatically format all files before saving
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = false }) -- Synchronous formatting
-- 	end,
-- })

-- lsp.setup()

-- vim.diagnostic.config({
-- 	virtual_text = true,
-- })

local lspkind = require("lspkind")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP keybindings",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end,
})

local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		lua = { "stylua" },
		-- c = { "clang-format" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
})

local lint = require("lint")
lint.linters_by_ft = {
	javascript = { "eslint_d" },
	-- c = { "clangtidy" },
}
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"lua_ls",
		"rust_analyzer",
		"clangd",
	},
	handlers = {
		function(server)
			lspconfig[server].setup({
				capabilities = lsp_capabilities,
			})
		end,
		lua_ls = function()
			lspconfig.lua_ls.setup({
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

--- loads custom snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
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
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

vim.diagnostic.config({
	-- update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
	focusable = false,
	max_width = 80,
	max_height = 20,
})
