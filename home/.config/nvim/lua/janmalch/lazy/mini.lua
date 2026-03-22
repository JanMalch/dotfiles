return {
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
