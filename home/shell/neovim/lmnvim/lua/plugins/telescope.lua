return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function(plugin)
				require("configs.telescope-fzf-native")(plugin)
			end,
		},
		{
			"jay-babu/project.nvim",
			event = "VeryLazy",
			config = function(_, opts)
				require("configs.project")(_, opts)
			end,
		},
	},
}
