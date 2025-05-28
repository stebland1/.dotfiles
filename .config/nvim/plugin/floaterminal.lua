vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	buf = -1,
	win = -1,
}

local function create_floating_window(opts)
	opts = opts or {}

	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
	})

	return { buf = buf, win = win }
end

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(state.win) then
		state = create_floating_window({ buf = state.buf })
		if vim.bo[state.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
		vim.cmd.startinsert()
	else
		vim.api.nvim_win_hide(state.win)
	end
end

vim.keymap.set({ "n", "t" }, "<M-1>", toggle_terminal)
