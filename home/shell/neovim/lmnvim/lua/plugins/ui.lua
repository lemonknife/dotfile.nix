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
				vim.o.statusline = ""
			else
				vim.o.laststatus = 0
			end
		end,
		dependencies = {
			"lemonknife/heirline-components.nvim",
			opts = {
				icons = {
					VimIcon = "",
					ScrollText = "",
					GitBranch = "",
					GitAdd = "",
					GitChange = "",
					GitDelete = "",
					FolderClosed = "",
				},
				separators = {
					left = { "", "" },
					right = { " ", "" }, -- separator for the right side of the statusline
					tab = { "", "" },
				},

				modes = {
					["n"] = { "NORMAL", "normal" },
					["no"] = { "OP", "normal" },
					["nov"] = { "OP", "normal" },
					["noV"] = { "OP", "normal" },
					["no"] = { "OP", "normal" },
					["niI"] = { "NORMAL", "normal" },
					["niR"] = { "NORMAL", "normal" },
					["niV"] = { "NORMAL", "normal" },
					["i"] = { "INSERT", "insert" },
					["ic"] = { "INSERT", "insert" },
					["ix"] = { "INSERT", "insert" },
					["t"] = { "TERM", "terminal" },
					["nt"] = { "TERM", "terminal" },
					["v"] = { "VISUAL", "visual" },
					["vs"] = { "VISUAL", "visual" },
					["V"] = { "LINES", "visual" },
					["Vs"] = { "LINES", "visual" },
					[""] = { "BLOCK", "visual" },
					["s"] = { "BLOCK", "visual" },
					["R"] = { "REPLACE", "replace" },
					["Rc"] = { "REPLACE", "replace" },
					["Rx"] = { "REPLACE", "replace" },
					["Rv"] = { "V-REPLACE", "replace" },
					["s"] = { "SELECT", "visual" },
					["S"] = { "SELECT", "visual" },
					[""] = { "BLOCK", "visual" },
					["c"] = { "COMMAND", "command" },
					["cv"] = { "COMMAND", "command" },
					["ce"] = { "COMMAND", "command" },
					["r"] = { "PROMPT", "inactive" },
					["rm"] = { "MORE", "inactive" },
					["r?"] = { "CONFIRM", "inactive" },
					["!"] = { "SHELL", "inactive" },
					["null"] = { "null", "inactive" },
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
								icon = { kind = "VimIcon", padding = { left = 1, right = 1 } },
							},
							-- surround the component with a separators
							surround = {
								-- it's a left element, so use the left separator
								separator = "left",
								-- set the color of the surrounding based on the current mode using astronvim.utils.status module
								color = function()
									return { main = lib.hl.mode_bg(), right = "blue" }
								end,
							},
						}),
						lib.component.builder({
							{ provider = "" },
							-- define the surrounding separator and colors to be used inside of the component
							-- and the color to the right of the separated out section
							surround = {
								separator = "left",
								color = { main = "blue", right = "bg_visual" },
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
								separator = "left",
								color = { main = "bg_visual" },
								condition = false,
							},
							hl = { fg = "fg" },
						}),
						lib.component.git_branch({
							git_branch = { padding = { left = 1 } },
							surround = { separator = "none" },
						}),
						lib.component.git_diff(),
						lib.component.diagnostics(),
						lib.component.fill(),
						lib.component.virtual_env(),
						lib.component.lsp({ separator = "right", lsp_progress = false }),
						{
							-- define a simple component where the provider is just a folder icon
							lib.component.builder({
								-- astronvim.get_icon gets the user interface icon for a closed folder with a space after it
								{ provider = require("heirline-components.utils").get_icon("FolderClosed") },
								-- add padding after icon
								padding = { right = 1 },
								-- set the foreground color to be used for the icon
								hl = { fg = "bg" },
								-- use the right separator and define the background color
								surround = { separator = "right", color = { main = "red1", right = "bg_visual" } },
							}),
							-- add a file information component and only show the current working directory name
							lib.component.builder({
								provider = function()
									local function get()
										local cwd = LazyVim.root.cwd()
										local root = LazyVim.root.get({ normalize = true })
										local name = vim.fs.basename(root)
										return name
									end
									return get() .. "/"
								end,
								hl = { fg = "fg", bold = true },
								surround = {
									separator = { " ", "" },
									color = { main = "bg_visual", left = "bg_visual" },
									condition = false,
								},
							}),
							lib.component.builder({
								provider = function()
									local function pretty_path()
										local opts = {
											relative = "cwd",
											modified_hl = "MatchParen",
											directory_hl = "",
											filename_hl = "Bold",
											modified_sign = "",
											length = 3,
										}

										local path = vim.fn.expand("%:p") --[[@as string]]

										if path == "" then
											return ""
										end

										path = LazyVim.norm(path)
										local root = LazyVim.root.get({ normalize = true })
										local cwd = LazyVim.root.cwd()

										if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
											path = path:sub(#cwd + 2)
										elseif path:find(root, 1, true) == 1 then
											path = path:sub(#root + 2)
										end

										local sep = package.config:sub(1, 1)
										local parts = vim.split(path, "[\\/]")

										if opts.length == 0 then
											parts = parts
										elseif #parts > opts.length then
											parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
										end

										if opts.modified_hl and vim.bo.modified then
											parts[#parts] = parts[#parts] .. opts.modified_sign
										end

										local dir = ""
										if #parts > 1 then
											dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
											dir = dir .. sep
										end

										return dir
									end
									return pretty_path()
								end,
								hl = { fg = "file_info_fg" },
								surround = {
									separator = { "", "" },
									color = { main = "bg_visual", left = "bg_visual" },
									condition = false,
								},
							}),
						},
						{ -- make nav section with icon border
							-- define a custom component with just a file icon
							lib.component.builder({
								{ provider = require("heirline-components.utils").get_icon("ScrollText") },
								-- add padding after icon
								padding = { right = 1 },
								-- set the icon foreground
								hl = { fg = "bg" },
								-- use the right separator and define the background color
								-- as well as the color to the left of the separator
								surround = {
									separator = "right",
									color = { main = "green", left = "bg_visual" },
								},
							}),
							-- add a navigation component and just display the percentage of progress in the file
							lib.component.nav({
								-- add some padding for the percentage provider
								percentage = { padding = { right = 1 } },
								-- disable all other providers
								ruler = false,
								scrollbar = false,
								-- use no separator and define the background color
								surround = { separator = "none", color = "bg_visual" },
							}),
						},
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
