require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "-" },
		untracked = { text = "?" },
	},
	signs_staged = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "-" },
	},
	signs_staged_enable = true,
	signcolumn = true,
	numhl = false,
	auto_attach = true,
	current_line_blame = true,
	on_attach = function(buffer)
		-- https://www.lazyvim.org/plugins/editor#gitsignsnvim
	end,
})
