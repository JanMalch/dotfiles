require("neotest").setup({
	settings = {
		watch = true,
	},
	adapter = {
		require("neotest-java"),
		require("neotest-nodejs"),
	},
})

vim.keymap.set("n", "<leader>tr", "<cmd>Neotest run<cr>", { desc = "Run tests" })
vim.keymap.set("n", "<leader>ti", "<cmd>Neotest output<cr>", { desc = "Show test outputs" })
vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary<cr>", { desc = "Show test summary" })
vim.keymap.set(
	"n",
	"<leader>ts",
	"<cmd>lua require('neotest').run.run({ suite = true })<cr>",
	{ desc = "Run test suite" }
)
