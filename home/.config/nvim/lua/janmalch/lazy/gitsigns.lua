return {
	"lewis6991/gitsigns.nvim",
	opts = {
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
		on_attach = function(buffer)
			-- https://www.lazyvim.org/plugins/editor#gitsignsnvim
		end,
	},
}
