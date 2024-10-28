local dap = require("dap")
local ui = require("dapui")

ui.setup()
require("nvim-dap-virtual-text").setup()

dap.adapters["pwa-node"] = {
	type = "server",
	host = "::1",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = {
			"${port}",
		},
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
	require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F7>", dap.continue)
vim.keymap.set("n", "<F8>", dap.step_into)
vim.keymap.set("n", "<F9>", dap.step_over)
vim.keymap.set("n", "<F10>", dap.step_out)
vim.keymap.set("n", "<F11>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end
