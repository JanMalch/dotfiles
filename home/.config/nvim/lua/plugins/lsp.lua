vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/artemave/workspace-diagnostics.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/rachartier/tiny-code-action.nvim",
})

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

require("tiny-inline-diagnostic").setup({
	preset = "simple",
	transparent_cursorline = false,
	options = {
		multilines = {
			enabled = true,
		},
	},
})

require("mason").setup()
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"eslint_d",
		"lua_ls",
		"ts_ls",
		"gopls",
		"jsonls",
		"yamlls",
		-- https://github.com/Kotlin/kotlin-lsp
		"kotlin_lsp",
		-- Java https://github.com/eclipse-jdtls/eclipse.jdt.ls
		"jdtls",
	},
	auto_update = false,
	run_on_start = true,
})

require("workspace-diagnostics").setup()
require("tiny-code-action").setup({
	picker = {
		"telescope",
		opts = {
			layout_strategy = "horizontal",
		},
	},
})

vim.api.nvim_create_autocmd(
	"LspAttach",
	{ --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client then
				if client:supports_method("workspace/diagnostic", ev.buf) then
					vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
				else
					require("workspace-diagnostics").populate_workspace_diagnostics(client, ev.buf)
				end
			end

			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

			local opts = function(desc)
				return { buffer = ev.buf, silent = true, desc = desc }
			end
			vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts("Hover documentation"))
			vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, opts("Rename symbol"))
			-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts("Go to definition"))
			-- vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts("Go to implementation"))
			-- vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts("Go to type definition"))
			-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts("Find references"))

			vim.keymap.set({ "n", "v" }, "<leader>fa", function()
				require("tiny-code-action").code_action({
					filter = function(action)
						return not action.disabled
					end,
				})
			end, opts("Code action"))
			vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, opts("Format buffer"))

			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float({
					border = "rounded",
				})
			end, opts("Show diagnostics float"))
		end,
	}
)
