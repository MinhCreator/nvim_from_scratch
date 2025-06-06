local quit_search = function()
    vim.cmd("nohlsearch")
end
-- quit_search
vim.api.nvim_create_user_command("Qsearch", quit_search, {})

-- toggle notification
local toggle_notify = function()
    vim.cmd("Telescope notify")
end
-- toggle_notify
vim.api.nvim_create_user_command("Tnotify", toggle_notify, {})

-- toggle spellwarn
vim.api.nvim_create_user_command("Tspell", function ()
    require("spellwarn").toggle()
end , {})

