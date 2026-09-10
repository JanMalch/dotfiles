vim.cmd("packadd nvim.undotree")

local gh = function(repo)
	return "https://github.com/" .. repo
end
vim.pack.add({
	-- File navigation
	gh("nvim-lua/plenary.nvim"), -- required by telescope
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	gh("nvim-telescope/telescope-frecency.nvim"),

	-- Appearance
	gh("catppuccin/nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("nvim-lualine/lualine.nvim"),
	gh("sitiom/nvim-numbertoggle"), -- switch to absolute numbers in insert mode
	gh("mluders/comfy-line-numbers.nvim"), -- only display left hand numbers
	gh("folke/todo-comments.nvim"),
	gh("romgrk/barbar.nvim"),
	gh("folke/twilight.nvim"),
	gh("folke/trouble.nvim"),
	gh("j-hui/fidget.nvim"),
	gh("lewis6991/gitsigns.nvim"),

	-- LSP, completion, and formatting
	gh("mason-org/mason-lspconfig.nvim"),
	gh("mason-org/mason.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	gh("b0o/SchemaStore.nvim"),
	gh("stevearc/conform.nvim"),
	gh("rachartier/tiny-code-action.nvim"),
	gh("L3MON4D3/LuaSnip"),
	gh("Saghen/blink.lib"),
	gh("Saghen/blink.cmp"),
	gh("mikavilpas/blink-ripgrep.nvim"),

	-- Syntax and editing
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-mini/mini.nvim"),
	gh("abecodes/tabout.nvim"),

	-- Diagnostics and command line
	gh("artemave/workspace-diagnostics.nvim"),
	gh("rachartier/tiny-inline-diagnostic.nvim"),

	-- Testing
	gh("nvim-neotest/neotest"),
	gh("nvim-neotest/nvim-nio"),
	gh("antoinemadec/FixCursorHold.nvim"),
	gh("mfussenegger/nvim-jdtls"),
	gh("rcasia/neotest-java"),
	gh("AkisArou/neotest-nodejs"),

	-- Utilities
	gh("folke/snacks.nvim"),
	gh("rmagatti/auto-session"),
	gh("yochem/jq-playground.nvim"),
})

require("plugins.theme")
require("plugins.blink")
require("plugins.diagnostics")
require("plugins.git")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.formatting")
require("plugins.misc")
require("plugins.mini")
require("plugins.snacks")
require("plugins.testing")
