local separators = {
	left = { "", "" },
	right = { " ", "" }, -- separator for the right side of the statusline
	tab = { "", "" },
}

return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = { style = "moon" },
	},

	{ "nvim-lualine/lualine.nvim", enabled = false },

	{
		"rebelot/heirline.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.heirline_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " "
			else
				vim.o.laststatus = 0
			end
		end,
		dependencies = {
			"Zeioth/heirline-components.nvim",
			opts = {
				icons = {
					VimIcon = "",
				},
			},
		},
		opts = function()
			local lib = require("heirline-components.all")

			vim.o.laststatus = vim.g.heirline_laststatus

			return {
				opts = {
					colors = require("tokyonight.colors").setup(),
					disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
						local is_disabled = not require("heirline-components.buffer").is_valid(args.buf)
							or lib.condition.buffer_matches({
								buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
								filetype = {
									"NvimTree",
									"snacks_dashboard",
									"neo%-tree",
									"dashboard",
									"Outline",
									"aerial",
								},
							}, args.buf)
						return is_disabled
					end,
				},
				statusline = {
					fallthrough = false,
					{
						hl = { fg = "fg", bg = "bg" },
						condition = function()
							local is_disabled = require("heirline.conditions").buffer_matches({
								buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
								filetype = { "NvimTree", "snacks_dashboard", "dashboard", "alpha", "ministarter" },
							})
							return is_disabled
						end,
						lib.component.fill(),
					},
					{
						hl = { fg = "fg", bg = "bg_dark" },
						lib.component.mode({
							-- enable mode text with padding as well as an icon before it
							mode_text = {
								icon = { padding = { right = 1, left = 1 } },
							},
							-- surround the component with a separators
							surround = {
								-- it's a left element, so use the left separator
								separator = separators.left,
								-- set the color of the surrounding based on the current mode using astronvim.utils.status module
								color = function()
									return { main = lib.hl.mode_bg(), right = "dark5" }
								end,
							},
						}),
						lib.component.builder({
							{ provider = "" },
							-- define the surrounding separator and colors to be used inside of the component
							-- and the color to the right of the separated out section
							surround = {
								separator = separators.left,
								color = { main = "dark5", right = "bg_visual" },
							},
						}),
						lib.component.file_info({
							-- enable the file_icon and disable the highlighting based on filetype
							filename = { fallback = "Empty" },
							-- disable some of the info
							filetype = false,
							file_read_only = false,
							-- add padding
							padding = { right = 1 },
							-- define the section separator
							surround = {
								separator = separators.left,
								color = { main = "bg_visual" },
								condition = false,
							},
						}),
						lib.component.git_branch({
							git_branch = { padding = { left = 1 } },
							surround = { separator = "none" },
						}),
						lib.component.git_diff(),
						lib.component.diagnostics(),
						lib.component.fill(),
						lib.component.cmd_info(),
						lib.component.fill(),
						lib.component.lsp(),
						lib.component.compiler_state(),
						lib.component.virtual_env(),
						lib.component.nav(),
					},
				},
			}
		end,
		config = function(_, opts)
			local heirline = require("heirline")
			local heirline_components = require("heirline-components.all")

			-- Setup
			heirline_components.init.subscribe_to_events()
			heirline.load_colors(heirline_components.hl.get_colors())
			heirline.setup(opts)
		end,
	},
}
