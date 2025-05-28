local debounce = function(fn, ms)
	local timer = nil
	return function(...)
		local args = { ... }
		if timer then
			timer:stop()
			timer:close()
		end
		timer = vim.loop.new_timer()
		timer:start(ms, 0, function()
			timer:stop()
			timer:close()
			timer = nil
			vim.schedule_wrap(fn)(unpack(args))
		end)
	end
end

return {
	"mfussenegger/nvim-lint",
	opts = {
		linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
		},
	},
	config = function(_, opts)
		local lint = require("lint")
		lint.linters_by_ft = opts.linters_by_ft
		local debounced_lint = debounce(function()
			lint.try_lint()
		end, 500)

		vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold" }, {
			callback = debounced_lint,
		})
		vim.keymap.set("n", "<leader>l", lint.try_lint, { noremap = true, silent = true })
	end,
}
