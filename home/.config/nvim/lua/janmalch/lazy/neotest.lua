return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		-- adapters
		"rcasia/neotest-java",
		"AkisArou/neotest-nodejs",
	},
	keys = {
		{ "<leader>tr", "<cmd>Neotest run<cr>" },
		{ "<leader>ti", "<cmd>Neotest output<cr>" },
		{ "<leader>ts", "<cmd>Neotest summary<cr>" },
		{ "<leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>" },
	},
	config = function()
		require("neotest").setup({
			settings = {
				watch = true,
			},
			adapter = {
				require("neotest-java"),
				require("neotest-nodejs"),
			},
		})
	end,
}
