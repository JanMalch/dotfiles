local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local code_action = require("tiny-code-action")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

-- https://github.com/tjdevries/advent-of-nvim/blob/13d4ec68a2a81f27264f3cc73dd7cd8c047aab87/nvim/lua/config/telescope/multigrep.lua
local live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end

			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end

			---@diagnostic disable-next-line: deprecated
			return vim.tbl_flatten({
				args,
				{
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

telescope.setup({
	defaults = {
		path_display = { "truncate", "filename_first" },
		mappings = {
			i = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
			n = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		frecency = {
			db_safe_mode = false,
			db_validate_threshold = 0,
			show_filter_column = false,
		},
		["ui-select"] = require("telescope.themes").get_dropdown({}),
	},
	pickers = {
		buffers = {
			mappings = {
				n = {
					["d"] = require("telescope.actions").delete_buffer,
					["q"] = require("telescope.actions").close,
				},
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("frecency")

code_action.setup({
	picker = {
		"telescope",
		opts = {
			layout_strategy = "horizontal",
		},
	},
})

-- keymaps
vim.keymap.set("n", "<leader>ff", function()
	builtin.git_files({ show_untracked = true })
end, { desc = "Find git file (Telescope)" })
vim.keymap.set("n", "<leader>fg", live_multigrep, { desc = "Find with live grep (Telescope)" })
vim.keymap.set("n", "<leader>fp", builtin.find_files, { desc = "Find project file (Telescope)" })
vim.keymap.set("n", "<leader>fw", function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end, { desc = "Find word (Telescope)" })
vim.keymap.set("n", "<leader>fW", function()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end, { desc = "Find Word (Telescope)" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags (Telescope)" })
vim.keymap.set("n", "<leader>fb", function()
	builtin.buffers({
		sort_mru = true,
		sort_lastused = true,
		initial_mode = "normal",
		ignore_current_buffer = true,
	})
end, { desc = "Find buffers (Telescope)" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymap (Telescope)" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX<cr>", { desc = "Find TODOs (Telescope)" })
vim.keymap.set(
	"n",
	"<leader>fr",
	"<cmd>Telescope frecency ignore_current_buffer=true<cr>",
	{ desc = "Find recent files (Telescope)" }
)

vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "Find workspace symbols (Telescope)" })
vim.keymap.set("n", "<leader>fS", builtin.lsp_document_symbols, { desc = "Find document symbols (Telescope)" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics (Telescope)" })
vim.keymap.set("n", "<leader>fD", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "Find file diagnostics (Telescope)" })

vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { desc = "Go to definitions" })
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, { desc = "Go to implementations" })
vim.keymap.set("n", "<leader>gt", builtin.lsp_type_definitions, { desc = "Go to type definitions" })
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "Go to references" })
