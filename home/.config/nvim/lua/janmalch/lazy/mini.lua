return {
	{
		"nvim-mini/mini.files",
		version = "*",
		keys = {
			{ "<leader>e", "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0))<cr>" },
			{ "<leader>E", "<cmd>lua require('mini.files').open(nil, false)<cr>" },
		},
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
