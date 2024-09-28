local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		cpp = { "clang-format" },
		c = { "clang-format" },
		nix = { "nixfmt" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return options
