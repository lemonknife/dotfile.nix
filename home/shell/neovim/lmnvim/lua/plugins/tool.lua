return {

	{
		"gbprod/yanky.nvim",
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
		opts = require("options.yanky"),
		keys = require("mappings.yanky"),
	},
}
