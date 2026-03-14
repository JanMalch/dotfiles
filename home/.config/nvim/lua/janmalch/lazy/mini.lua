return {
	{
		"nvim-mini/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()
			vim.keymap.set("n", "<leader>e", function()
				MiniFiles.open()
			end, { silent = true })
		end,
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
}
