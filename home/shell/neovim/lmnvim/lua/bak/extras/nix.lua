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
}
