local options = {
	ensure_installed = {
		"lua",
		"luadoc",
		"printf",
		"vim",
		"vimdoc",
		"ssh_config",
		"cpp",
		"nix",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = false },
}

return options
