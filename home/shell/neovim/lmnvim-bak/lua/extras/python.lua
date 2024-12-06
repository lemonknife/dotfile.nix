return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
				},
				basedpyright = {},
			},
			setup = {
				ruff = function()
					LazyVim.lsp.on_attach(function(client, _)
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end, "ruff")
				end,
			},
		},
	},
}
