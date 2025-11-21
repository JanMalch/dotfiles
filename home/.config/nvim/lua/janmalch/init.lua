require("janmalch.set")
require("janmalch.remap")
require("janmalch.lazy_init")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
