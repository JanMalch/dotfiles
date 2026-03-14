-- ":so" to source this file
vim.g.mapleader = " "
-- project view: in normal mode, press "<leader>pv" to open vim's file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keep cursor in the same place when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- paste to replace, but keep clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- unbind worst thing in the universe...?
vim.keymap.set("n", "Q", "<nop>")
-- quick fix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- pane navigation (e.g. for jq-playground)
vim.keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { silent = true })
-- https://github.com/yochem/jq-playground.nvim
---- start the playground
vim.keymap.set("n", "<leader>jq", vim.cmd.JqPlayground)
---- when in the query window, run the jq query
vim.keymap.set("n", "R", "<Plug>(JqPlaygroundRunQuery)")
-- buffers AKA tabs
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
