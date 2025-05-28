local is_termux = vim.fn.has("unix") == 1 and vim.fn.executable("termux-info") == 1
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	nmap("gd", vim.lsp.buf.definition, "Go to Definition")
	nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("gi", vim.lsp.buf.hover, "Go to Implementation")
	nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
	nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	nmap("gr", vim.lsp.buf.references, "Show References")
	nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
	nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = is_termux and {
		{ "j-hui/fidget.nvim", opts = {} },
	} or {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
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

		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.clangd.setup({
			cmd = { "clangd" },
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
