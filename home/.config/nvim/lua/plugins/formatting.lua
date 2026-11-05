vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

local prettier = { "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
	format_on_save = {
		timeout_ms = 8000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = prettier,
		javascriptreact = prettier,
		typescript = prettier,
		typescriptreact = prettier,
		go = { "goimports", "gofmt" },
		json = prettier,
		html = prettier,
		markdown = prettier,
		yaml = prettier,
		sh = { "shfmt" },
		kotlin = { "ktfmt" },
	},
	formatters = {
		sql_formatter = {
			prepend_args = { "--language", "postgresql" },
		},
	},
})
