dofile(vim.g.base46_cache .. "lsp")
-- local lspconfig = require("lspconfig")
local lsp = require("configs.lsp")
local map = vim.keymap.set
local vlsp = vim.lsp
-- lsp with multiple language server config


for _, lsps in ipairs(lsp.server) do
	vlsp.enable(lsps)
	vlsp.config(lsps, {
		capabilities = {
			textDocument = {
				completion = {
					completionItem = {
						documentationFormat = { "markdown", "plaintext" },
						snippetSupport = true,
						preselectSupport = true,
						insertReplaceSupport = true,
						labelDetailsSupport = true,
						deprecatedSupport = true,
						commitCharactersSupport = true,
						tagSupport = { valueSet = { 1 } },
						resolveSupport = {
							properties = {
								"documentation",
								"detail",
								"additionalTextEdits",
							},
						},
					},
				}
			},
		}

	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			
			vlsp.handlers["textDocument/publishDiagnostics"] =
				vlsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
					signs = true,
				})

			local function opts(desc)
				return { buffer = bufnr, desc = "LSP " .. desc }
			end

			map("n", "gD", vlsp.buf.declaration, opts("Go to declaration"))
			map("n", "gd", vlsp.buf.definition, opts("Go to definition"))
			map("n", "<leader>wa", vlsp.buf.add_workspace_folder, opts("Add workspace folder"))
			map("n", "<leader>wr", vlsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
			map("n", "<leader>wl", function()
				print(vim.inspect(vlsp.buf.list_workspace_folders()))
			end, opts("List workspace folders"))

			map("n", "<leader>D", vlsp.buf.type_definition, opts("Go to type definition"))
			-- map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "Renamer")
			map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts("Renamer"))
		end
	})
end

-- lsp progress notifiy
local progress = vim.defaulttable()
local api = vim.api

-- simple lsp progress
api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(vim.lsp.status(), "info", {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

-- advanced lsp progress
-- api.nvim_create_autocmd("LspProgress", {
-- 	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		local value = ev.data.params
-- 		.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
-- 		if not client or type(value) ~= "table" then
-- 			return
-- 		end
-- 		local p = progress[client.id]

-- 		for i = 1, #p + 1 do
-- 			if i == #p + 1 or p[i].token == ev.data.params.token then
-- 				p[i] = {
-- 					token = ev.data.params.token,
-- 					msg = ("[%3d%%] %s%s"):format(
-- 						value.kind == "end" and 100 or value.percentage or 100,
-- 						value.title or "",
-- 						value.message and (" **%s**"):format(value.message) or ""
-- 					),
-- 					done = value.kind == "end",
-- 				}
-- 				break
-- 			end
-- 		end

-- 		local msg = {} ---@type string[]
-- 		progress[client.id] = vim.tbl_filter(function(v)
-- 			return table.insert(msg, v.msg) or not v.done
-- 		end, p)

-- 		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
-- 		vim.notify(table.concat(msg, "\n"), "info", {
-- 			id = "lsp_progress",
-- 			title = client.name,
-- 			opts = function(notif)
-- 				notif.icon = #progress[client.id] == 0 and " "
-- 					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
-- 			end,
-- 		})
-- 	end,
-- })
