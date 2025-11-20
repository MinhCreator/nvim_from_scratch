local picker = function ()
    return Snacks.picker
end
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        dependencies = { "nvim-tree/nvim-web-devicons" },

        opts = {
            toggle = {
                map = vim.keymap.set, -- keymap.set function to use
                which_key = true,     -- integrate with which-key to show enabled/disabled icons and colors
                notify = true,        -- show a notification when toggling
                -- icons for enabled/disabled states
                icon = {
                    enabled = " ",
                    disabled = " ",
                },
                -- colors for enabled/disabled states
                color = {
                    enabled = "green",
                    disabled = "yellow",
                },
                wk_desc = {
                    enabled = "Disable ",
                    disabled = "Enable ",
                },
            },
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = true },
            input = {
                enabled = true,
                {
                    icon = " ",
                    icon_hl = "SnacksInputIcon",
                    icon_pos = "left",
                    prompt_pos = "title",
                    win = { style = "input" },
                    expand = true,
                },
                backdrop = 30,
                position = "float",
                border = "rounded",
                title_pos = "center",
                height = 1,
                width = 60,
                relative = "editor",
                noautocmd = true,
            },

            picker = { enabled = true },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            -- Snacks Profiler
            { "<leader>pp", function() Snacks.toggle.profiler() end, desc = "Snacks Profiler" },
            { "<leader>ph", function() Snacks.toggle.profiler_highlights() end, desc = "Snacks Profiler Highlights" },
            { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
            
            -- Top Pickers & Explorer
            { "<leader>s", "", desc = "󱥰 Snacks Qol" },
            { "<leader>s<space>", function() picker.smart() end, desc = "Smart Find Files" },
            -- { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>s/", function() picker.grep() end, desc = "Grep" },
            { "<leader>s:", function() picker.command_history() end, desc = "Command History" },
            
            -- find
            { "<leader>sfb", function() picker.buffers() end, desc = "Buffers" },
            { "<leader>sff", function() picker.files() end, desc = "Find Files" },
            
            -- git
            { "<leader>stb", function() picker.git_branches() end, desc = "Git Branches" },
            { "<leader>stl", function() picker.git_log() end, desc = "Git Log" },
            { "<leader>stL", function() picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>sts", function() picker.git_status() end, desc = "Git Status" },
            { "<leader>stS", function() picker.git_stash() end, desc = "Git Stash" },
            { "<leader>std", function() picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>stf", function() picker.git_log_file() end, desc = "Git Log File" },
           
            -- Grep
            { "<leader>sb", function() picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sg", function() picker.grep() end, desc = "Grep" },
            { "<leader>sw", function() picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
            { "<leader>sa", function() picker.autocmds() end, desc = "Autocmds" },
            { "<leader>s<S-b>", function() picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sC", function() picker.commands() end, desc = "Commands" },
            { "<leader>sd", function() picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sD", function() picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>s?", function() picker.help() end, desc = "Help Pages" },
            { "<leader>sH", function() picker.highlights() end, desc = "Highlights" },
            { "<leader>si", function() picker.icons() end, desc = "Icons" },
            { "<leader>sj", function() picker.jumps() end, desc = "Jumps" },
            -- { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
            { "<leader>sl", function() picker.loclist() end, desc = "Location List" },
            { "<leader>sm", function() picker.marks() end, desc = "Marks" },
            -- { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
            { "<leader>sp", function() picker.lazy() end, desc = "Search for Plugin Spec" },
            { "<leader>sq", function() picker.qflist() end, desc = "Quickfix List" },
            { "<leader>sR", function() picker.resume() end, desc = "Resume" },
            { "<leader>su", function() picker.undo() end, desc = "Undo History" },
            
            -- LSP
            { "<leader>sld", function() picker.lsp_definitions() end, desc = "Goto Definition" },
            { "<leader>slD", function() picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "<leader>slr", function() picker.lsp_references() end, nowait = true, desc = "References" },
            { "<leader>slI", function() picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "<leader>sly", function() picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "<leader>ss", function() picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<leader>sS", function() picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

            { "<leader>sr", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<leader>stB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>sg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

        },

    }
}
