vim.pack.add({
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = false,
	float = {
		transparent = true,
	},
})

vim.cmd.colorscheme("catppuccin")

require("nvim-web-devicons").setup({})
