-- only use left hand for line numbers
require("comfy-line-numbers").setup({})

-- easily tab out of brackets, quotes etc
require("tabout").setup({})

-- highlight TODO comments
require("todo-comments").setup({})

-- interact with jq in Neovim using interactive buffers
require("jq-playground").setup({})
vim.keymap.set("n", "<leader>jq", vim.cmd.JqPlayground, { desc = "Open buffer in jq playground" })
vim.keymap.set("n", "R", "<Plug>(JqPlaygroundRunQuery)", { desc = "Run jq command in playground" })

-- reopen files
require("auto-session").setup({
	suppressed_dirs = { "~/", "~/Downloads", "/" },
	-- log_level = 'debug',
})

-- loading spinners
require("fidget")
