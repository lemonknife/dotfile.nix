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

	-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
	{
		"lemonknife/noice.nvim",
		branch = "personal-use-spinner",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			format = {
				spinner = { name = "arcFiraCode", hl_group = "NoiceLspProgressSpinner" },
			},
		},
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "LazyFile",
		opts = function()
			Snacks.toggle({
				name = "Indention Guides",
				get = function()
					return require("ibl.config").get_config(0).enabled
				end,
				set = function(state)
					require("ibl").setup_buffer(0, { enabled = state })
				end,
			}):map("<leader>ug")

			return {
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = { show_start = false, show_end = false },
				exclude = {
					filetypes = {
						"Trouble",
						"alpha",
						"dashboard",
						"help",
						"lazy",
						"mason",
						"neo-tree",
						"notify",
						"snacks_dashboard",
						"snacks_notif",
						"snacks_terminal",
						"snacks_win",
						"toggleterm",
						"trouble",
					},
				},
			}
		end,
		main = "ibl",
	},

	-- icons
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
}
