return {
	"nvim-lua/plenary.nvim",

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = function()
			return require("nvchad.configs.mason")
		end,
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
}
