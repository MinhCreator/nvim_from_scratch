-- autopairs-config.lua

-- Setup autopairs with nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end
local handlers = require('nvim-autopairs.completion.handlers')

npairs.setup {
    check_ts = true,
    -- ts_config = {
    --     lua = { "string", "source" },
    --     javascript = { "string", "template_string" },
    --     java = false,
    -- },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}


local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {
    filetypes = {
        -- "*" is a alias to all filetypes
        ["*"] = {
            ["("] = {
                kind = {
                    cmp.lsp.CompletionItemKind.Function,
                    cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"]
            }
        },
    },
    map_char = { tex = "" },
})
