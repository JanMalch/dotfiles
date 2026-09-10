local util = require("conform.util")

local eslint_config = {
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	"eslint.config.mts",
	"eslint.config.cts",
	".eslintrc",
	".eslintrc.json",
	".eslintrc.yml",
	".eslintrc.yaml",
	".eslintrc.js",
	".eslintrc.cjs",
}

local javascript_formatters = { "eslint", "prettierd", "prettier" }
local json_formatters = { "prettierd", "prettier" }

require("conform").setup({
	format_on_save = {
		timeout_ms = 8000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = javascript_formatters,
		javascriptreact = javascript_formatters,
		typescript = javascript_formatters,
		typescriptreact = javascript_formatters,
		go = { "goimports", "gofmt" },
		json = json_formatters,
		kotlin = { "ktfmt" },
	},
	formatters = {
		eslint = {
			command = util.from_node_modules("eslint"),
			args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
			condition = function(_, ctx)
				return vim.fs.root(ctx.dirname, eslint_config) ~= nil
			end,
		},
		sql_formatter = {
			prepend_args = { "--language", "postgresql" },
		},
	},
})
