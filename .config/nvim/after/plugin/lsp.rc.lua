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
	"rust_analyzer",
})

local null_opts = lsp.build_options("null-ls", {})

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

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

		local format_cmd = function(input)
			vim.lsp.buf.format({
				id = client.id,
				timeout_ms = 5000,
				async = input.bang,
			})
		end

		local bufcmd = vim.api.nvim_buf_create_user_command
		bufcmd(bufnr, "NullFormat", format_cmd, {
			bang = true,
			range = true,
			desc = "Format using null-ls",
		})
	end,
	sources = {
		-- formatting
		formatting.stylua,
		formatting.prettier,
		formatting.shfmt,
		-- formatting.eslint_d,
		formatting.golines,
		formatting.black.with({
			command = vim.fn.getcwd() .. "/.env/bin/black",
		}),
		-- -- diagnostics
		-- diagnostics.eslint_d,
		-- code actions
		code_actions.eslint_d,
	},
})

lsp.configure("tailwindcss", {
	root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	if string.match(value.targetUri, "react/index.d.ts") then
		return false
	end

	if string.match(value.targetUri, "react/ts5.0/index.d.ts") then
		return false
	end

	return true
end

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

lsp.configure("tsserver", {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		client.server_capabilities.semanticTokens = false
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.format()<CR>", {})
	end,
	handlers = {
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.tbl_islist(result) and #result > 1 then
				local filtered_result = filter(result, filterReactDTS)
				return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
			end

			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
	settings = {
		javascript = {
			format = {
				indentSize = vim.o.shiftwidth,
				convertTabsToSpaces = vim.o.expandtab,
				tabSize = vim.o.tabstop,
				insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
				insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
			},
		},
		tsserver_format_options = {
			insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
		},
		-- strictNullChecks = true,
		diagnostics = {
			ignoredCodes = {
				7016, -- "Could not find a declaration file for module..."
				7044, -- "Implicit any..."
			},
		},
	},
})

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

	-- Format using null ls
	local formatGrp = vim.api.nvim_create_augroup("FormattingGroup", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		command = "NullFormat",
		group = formatGrp,
	})
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
