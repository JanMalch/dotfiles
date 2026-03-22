return {
	"stevearc/overseer.nvim",
	lazy = true,
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {},
	config = function()
		require("overseer").setup()
	end,
}
