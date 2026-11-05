vim.pack.add({
	"https://github.com/Saghen/blink.lib",
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
	"https://github.com/L3MON4D3/LuaSnip",
})

-- require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	snippets = { preset = "luasnip" },
	keymap = {
		preset = "default",
		["<Tab>"] = { "accept", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-Space>"] = { "show" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
	},
	completion = {
		ghost_text = {
			enabled = true,
		},
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		documentation = { auto_show = true },
	},
	signature = { enabled = true },
	fuzzy = {
		implementation = "prefer_rust_with_warning",
		max_typos = function(keyword)
			return math.floor(#keyword / 4)
		end,
		frecency = {
			enabled = true,
			path = vim.fn.stdpath("state") .. "/blink/cmp/frecency.dat",
		},
	},
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
			"ripgrep",
		},
		per_filetype = {
			sql = { "lsp", "snippets", "buffer" },
		},
		providers = {
			lsp = {
				score_offset = 90,
			},
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				opts = {
					prefix_min_len = 3,
					backend = {
						use = "gitgrep-or-ripgrep",
					},
				},
			},
		},
	},
})
