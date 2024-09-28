return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				nixd = {
					options = {
						home_manager = {
							expr = '(builtins.getFlake "/home/lemon/dotfiles").homeConfigurations."lemon@lemon".options',
						},
					},
				},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				nix = { "nixfmt" },
			},
		},
	},
}
