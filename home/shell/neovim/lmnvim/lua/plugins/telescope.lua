return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
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
			cmd = "ProjectRoot",
			opts = {
				manual_mode = true,
			},
			config = function(_, opts)
				require("configs.project")(_, opts)
			end,
		},
	},
}
