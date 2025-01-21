local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
	return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local lspconfig = require("lspconfig")
local util = lspconfig.util

lsp.preset("recommended")

lsp.ensure_installed({
	"ts_ls",
	"lua_ls",
	"pyright",
	"bashls",
})

local null_opts = lsp.build_options("null-ls", {})

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

lspconfig.bashls.setup({
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_dir = lspconfig.util.root_pattern(".git", "."),
	settings = {
		bash = {
			strict = true,
		},
	},
})

lspconfig.eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

lspconfig.pyright.setup({
	settings = {
		python = {
			-- Automatically use the Python interpreter from the active virtualenv
			pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
		},
	},
	on_attach = function(client, bufnr)
		-- Make sure null-ls is attached for Python formatting
		null_ls.register({
			-- Python formatter: `black`
			formatting = {
				command = "black", -- Use black for Python formatting
				args = { "--quiet", "-" },
			},
		})
	end,
})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		-- formatting
		formatting.stylua,
		formatting.prettier,
		formatting.shfmt,
		formatting.black.with({
			command = vim.fn.getcwd() .. "/.env/bin/black",
		}),
		code_actions.eslint_d,
	},
})

lsp.configure("tailwindcss", {
	root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
})

lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				-- Fix Undefined global 'vim'
				globals = { "vim" },
			},
		},
	},
})

lsp.configure("ts_ls")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item(cmp_select)
		else
			fallback()
		end
	end,
	["<C-n>"] = function(fallback)
		if cmp.visible() then
			cmp.select_next_item(cmp_select)
		else
			fallback()
		end
	end,
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false, silent = true }

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
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "[d", function()
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
end)

-- Automatically format all files before saving
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false }) -- Synchronous formatting
	end,
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
