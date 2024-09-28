local options = {
	ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "cpp" },

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true, disable = { "python" } },
}

return options
