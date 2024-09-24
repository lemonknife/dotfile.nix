return {
	"nvim-lua/plenary.nvim",

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("options.conform"),
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = require("options.mason"),
		config = function(_, opts)
			if opts.ensure_installed then
				vim.api.nvim_echo({
					{
						"\n   ensure_installed has been removed!",
						"WarningMsg",
					},
				}, false, {})
			end

			require("mason").setup(opts)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = require("options.telescope"),
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
}
