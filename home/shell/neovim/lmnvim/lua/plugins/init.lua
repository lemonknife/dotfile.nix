LazyVim = require("lazyvim.util")
LazyVim.config = require("lazyvim.config")

return {
	"nvim-lua/plenary.nvim",

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("options.conform"),
	},

	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		opts = require("options.treesitter"),
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		opts = require("options.lspconfig"),
		config = function(_, opts)
			require("configs.lspconfig")(_, opts)
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
		dependencies = {
			"stevearc/dressing.nvim",
			opts = {
				input = {
					win_options = {
						winblend = 10,
						winhighlight = "Normal:Normal,FloatBorder:NormalBorder,CursorLine:PmenuSel,Search:None",
					},
				},
			},
		},
		opts = require("options.nvimtree"),
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		},
	},
}
