return {

	{
		"gbprod/yanky.nvim",
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
		opts = require("configs.yanky"),
		keys = require("mappings.yanky"),
	},
}
