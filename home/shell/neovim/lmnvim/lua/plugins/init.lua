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
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function(plugin)
					require("configs.telescope-fzf-native")(plugin)
				end,
			},
		},
		opts = require("configs.telescope"),
		keys = require("mappings.telescope"),
	},
}
