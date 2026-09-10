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
		lualine_a = { "mode" },
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
		},
		lualine_z = {},
	},
	extensions = { "quickfix", "oil" },
})
