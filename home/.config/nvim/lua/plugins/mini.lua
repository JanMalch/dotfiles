-- enhanced, a and i keybinds
require("mini.ai").setup()

-- auto pairs
require("mini.pairs").setup()

-- access to surround keymaps sa,sd,sc etc
require("mini.surround").setup()

-- file explorer
local files = require("mini.files")
files.setup()

vim.keymap.set(
	"n",
	"<leader>e",
    function()
files.open(vim.api.nvim_buf_get_name(0))
    end,
	{ desc = "File explorer at current directory" }
)
vim.keymap.set(
	"n",
	"<leader>E",
    function()
        files.open(nil, false)
    end,
	{ desc = "File explorer at root directory" }
)
