return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"nvim-neotest/neotest",
		"nvim-neotest/neotest-python",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		dap_python.setup(vim.fn.getcwd() .. "/.venv/bin/python")
		dapui.setup()
		dap.set_log_level("DEBUG")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.after.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.after.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F12>", dap.step_out)
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
	end,
}
