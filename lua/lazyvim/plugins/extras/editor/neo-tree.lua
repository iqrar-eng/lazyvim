return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start", { clear = true }),
        callback = function()
          vim.schedule(function()
            local home = vim.fn.expand("~")
            require("neo-tree.command").execute({ toggle = true, dir = home })
            vim.cmd("wincmd p")
          end)
        end,
      })
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_ignored = false, -- hide files that are ignored by other gitignore-like files
          hide_hidden = false,  -- only works on Windows for hidden files/directories
        },
        components = {
          name = function(config, node, state)
            local name = node.name
            if node.type == "file" then
              name = vim.fn.fnamemodify(name, ":t:r") -- Get filename without extension
            end
            local highlight = config.highlight or "NeoTreeFileName"
            return {
              text = name,
              highlight = highlight,
            }
          end,
        },
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        use_libuv_file_watcher = true,
      },
      window = {
        position = "left",
        width = 33,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["E"] = function(state)
            local node = state.tree:get_node()
            if node then
              local basename = vim.fn.fnamemodify(node.path, ":t:r")
              vim.fn.setreg("+", basename)
              vim.notify(basename, vim.log.levels.INFO)
            end
          end,
          ["W"] = function(state)
            local node = state.tree:get_node()
            if node then
              local filename = vim.fn.fnamemodify(node.path, ":t")
              vim.fn.setreg("+", filename)
              vim.notify(filename, vim.log.levels.INFO)
            end
          end,
          [","] = function(state)
            local node = state.tree:get_node()
            if node then
              vim.fn.setreg("+", node.path)
              vim.notify(node.path, vim.log.levels.INFO)
            end
          end,
          ["S"] = function(state)
            local node = state.tree:get_node()
            if node then
              local path_home = vim.fn.fnamemodify(node.path, ":~")
              vim.fn.setreg("+", path_home)
              vim.notify(path_home, vim.log.levels.INFO)
            end
          end,
          [";"] = function(state)
            local node = state.tree:get_node()
            if node then
              local uri = vim.uri_from_fname(node.path)
              vim.fn.setreg("+", uri)
              vim.notify(uri, vim.log.levels.INFO)
            end
          end,
          ["G"] = function(state)
            vim.cmd("normal P")
            vim.cmd("wincmd l")
          end,
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = false,
              use_snacks_image = true,
              use_image_nvim = true,
            },
          },
          ['D'] = function(state)
            local node = state.tree:get_node()
            vim.fn.delete(node.path, 'rf')
            require("neo-tree.sources.manager").refresh(state.name)
          end,
          ['J'] = 'expand_all_subnodes',
          ["K"] = "close_all_nodes",
          ['H'] = 'close_all_subnodes',
          ["<c-k>"] = { "scroll_preview", config = { direction = 46 } },
          ["<c-j>"] = { "scroll_preview", config = { direction = -46 } },
          ["m"] = {
            "move",
            config = {
              show_path = "absolute", -- "none", "relative", "absolute"
            },
          },
          ["c"] = {
            "copy",
            config = {
              show_path = "absolute", -- "none", "relative", "absolute"
            },
          },
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 1,
          with_expanders = false, -- if nil and file nesting is enabled, will enable expanders
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
        },
        modified = {
          symbol = "",
        },
      },
    },
    config = function(_, opts)
      -- Add your setting here
      opts.hide_root_node = true

      -- Your rename handler
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      -- Apply setup with merged opts
      require("neo-tree").setup(opts)

      -- Lazygit autocmd
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end
  },
}
