vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/trouble.nvim",
})

local lualine = require("lualine")
local trouble = require("trouble")
local symbols = trouble.statusline({
	mode = "lsp_document_symbols",
	groups = {},
	title = false,
	filter = { range = true },
	format = "{kind_icon}{symbol.name:Normal}",
	-- The following line is needed to fix the background color
	-- Set it to the lualine section you want to use
	hl_group = "lualine_c_normal",
})

lualine.setup({
	options = {
		component_separators = "",
	},
	sections = {
		lualine_a = {
			"mode",
			{
				"selectioncount",
				cond = function()
					local mode = vim.api.nvim_get_mode()["mode"]:sub(1, 1)
					return mode == "v" or mode == "V"
				end,
				fmt = function(name)
					return "(" .. name .. ")"
				end,
			},
		},
		lualine_c = { { "filename", path = 4 }, { symbols.get, cond = symbols.has } },
		lualine_b = { "branch", "diff" },
		lualine_x = {
			{
				"filetype",
				cond = function()
					return vim.fn.reg_recording() == ""
				end,
			},
			{
				function()
					return "Recording @" .. vim.fn.reg_recording()
				end,
				cond = function()
					return vim.fn.reg_recording() ~= ""
				end,
				padding = 1,
			},
		},
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_workspace_diagnostic" },
			},
			{
				"lsp_status",
				icon = "", -- f013
				symbols = {
					-- Standard unicode symbols to cycle through for LSP progress:
					spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					-- Standard unicode symbol for when LSP is done:
					done = "✓",
					-- Delimiter inserted between LSP names:
					separator = " ",
				},
				-- List of LSP names to ignore (e.g., `null-ls`):
				ignore_lsp = {},
				-- Display the LSP name
				show_name = true,
			},
		},
		lualine_z = {},
	},
	extensions = { "quickfix" },
})
