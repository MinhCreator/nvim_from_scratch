local map = vim.keymap.set

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "quit terminal mode" })
map("n", "<F1>", "<cmd>Floaterminal<cr>", { desc = "toggle_terminal" })
local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}
local api = vim.api
local o = vim.o
local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(o.columns * 0.8)
	local height = opts.height or math.floor(o.lines * 0.8)

	-- Calculate the position to center the window
	local col = math.floor((o.columns - width) / 2)
	local row = math.floor((o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
	}

	-- Create the floating window
	local win = api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
			-- vim.cmd("insert")
		end
	else
		api.nvim_win_hide(state.floating.win)
	end
end

-- Example usage:
-- Create a floating window with default dimensions
api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

