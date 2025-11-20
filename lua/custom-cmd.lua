local api = vim.api
local cmd = vim.cmd
local quit_search = function()
	cmd("nohlsearch")
end
--quit_search
api.nvim_create_user_command("Qsearch", quit_search, {})

-- toggle notification
local toggle_notify = function()
	cmd("Telescope notify theme=dropdown")
	-- cmd("require('telescope').extensions.notify.notify({theme = 'dropdown'})")
end
-- toggle_notify
api.nvim_create_user_command("Tnotify", toggle_notify, {})

-- toggle spellwarn
api.nvim_create_user_command("Tspell", function()
	require("spellwarn").toggle()
end, {})

-- add go to line
local go_to_line = function()
	local line = vim.fn.input("Go to: " .. "line " .. vim.fn.line("w0") .. " to max line " .. vim.fn.line("$"))
	if tonumber(line) then
		-- vim.cmd("normal! " .. line .. "G")
		cmd(line)
	else
		vim.notify("Invalid line number", "warn", {
			title = "Go to Line",
		})
	end
end

api.nvim_create_user_command("Gline", go_to_line, {
	nargs = 0,
	desc = "Go to a specific line in the current buffer",
})
