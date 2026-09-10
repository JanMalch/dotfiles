require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = false,
	float = {
		transparent = true,
	},
})

vim.cmd.colorscheme("catppuccin")

require("nvim-web-devicons").setup({})

-- I like tabs to get an overview of open files and having an idea where to jump
require("barbar").setup({})
vim.keymap.set("n", "<C-p>", "<Cmd>bp<CR>", { silent = true, desc = "[P]revious buffer" })
vim.keymap.set("n", "<C-n>", "<Cmd>bn<CR>", { silent = true, desc = "[N]ext buffer" })
vim.keymap.set("n", "<C-q>", "<Cmd>bd<CR>", { silent = true, desc = "[Q]uit buffer" })
vim.keymap.set("n", "<leader><BS>", "<Cmd>e #<CR>", { silent = true, desc = "Alternate buffer" })
local opts = { noremap = true, silent = true }
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", opts)
end
vim.keymap.set("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
vim.keymap.set("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)
vim.keymap.set("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferPin<CR>", opts)
vim.keymap.set("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts)
vim.keymap.set("n", "<leader>bs", "<Cmd>BufferPick<CR>", opts)
