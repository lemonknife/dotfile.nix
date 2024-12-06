---@class PluginLspOpts
local options = {
	-- options for vim.diagnostic.config()
	---@type vim.diagnostic.Opts
	diagnostics = {
		underline = true,
		update_in_insert = false,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
			-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
			-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
			-- prefix = "icons",
		},
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
		},
	},
	-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
	-- Be aware that you also will need to properly configure your LSP server to
	-- provide the inlay hints.
	inlay_hints = {
		enabled = true,
		exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
	},
	-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
	-- Be aware that you also will need to properly configure your LSP server to
	-- provide the code lenses.
	codelens = {
		enabled = false,
	},
	-- Enable lsp cursor word highlighting
	document_highlight = {
		enabled = true,
	},
	-- add any global capabilities here
	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},
	setup = {},
}
return options
