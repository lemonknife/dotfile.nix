vim.g.lazyvim_picker = "telescope"

local picker = {
  name = "telescope",
  commands = {
    files = "find_files",
  },
  -- this will return a function that calls telescope.
  -- cwd will default to lazyvim.util.get_root
  -- for `files`, git_files or find_files will be chosen depending on .git
  ---@param builtin string
  ---@param opts? lazyvim.util.pick.Opts
  open = function(builtin, opts)
    opts = opts or {}
    opts.follow = opts.follow ~= false
    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
      local function open_cwd_dir()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick.open(
          builtin,
          vim.tbl_deep_extend("force", {}, opts or {}, {
            root = false,
            default_text = line,
          })
        )
      end
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        -- opts.desc is overridden by telescope, until it's changed there is this fix
        map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end,
}

if not LazyVim.pick.register(picker) then
  return {}
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  opts = function()
    local function find_command()
      return { "rg", "--files", "--color", "never", "-g", "!.git" }
    end

    local actions = require("telescope.actions")

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          n = {
            ["q"] = actions.close,
            ["<esc>"] = false,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,

  keys = require("mappings.telescope"),
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function(plugin)
        require("configs.telescope-fzf-native")(plugin)
      end,
    },
    {
      "stevearc/dressing.nvim",
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.input(...)
        end
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
