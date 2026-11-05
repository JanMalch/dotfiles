vim.pack.add({
	"https://github.com/abecodes/tabout.nvim",
	"https://github.com/rmagatti/auto-session",
})

-- easily tab out of brackets, quotes etc
require("tabout").setup({})

-- reopen files
require("auto-session").setup({
	suppressed_dirs = { "~/", "~/Downloads", "/" },
	-- log_level = 'debug',
})
