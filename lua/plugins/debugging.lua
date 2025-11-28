-- this feature is not working yet I may Tries to fix it later
return {
	{
		"mfussenegger/nvim-dap",
		-- enabled = false,
		event = { "BufRead", "BufWrite" },
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "nvim-neotest/nvim-nio" },
			{ "jay-babu/mason-nvim-dap.nvim" },
			{ "theHamsta/nvim-dap-virtual-text" }
		},

		config = function()
			require("nvim-dap-virtual-text").setup()
			require("dapui").setup()
			require("mason-nvim-dap").setup({ handlers = {}, })

		end,
	},
}
