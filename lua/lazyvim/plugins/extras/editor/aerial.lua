return {
  desc = "Aerial Symbol Browser",
  {
    "stevearc/aerial.nvim",
    event = "LazyFile",
    opts = function()
      local icons = vim.deepcopy(LazyVim.config.icons.kinds)
      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      icons.lua = { Package = icons.Control }
      ---@type table<string, string[]>|false
      for kind, icon in pairs(icons) do
        if type(icon) == "string" then
          icons[kind] = icon:gsub("%s+$", "") -- Remove trailing whitespace
        end
      end

      local opts = {
        keymaps = {
          ["G"] = function(state)
            vim.cmd("wincmd l")
            vim.cmd("normal! 'x")
          end,
          ["J"] = "actions.tree_open_all",
          ["K"] = "actions.tree_close_all",
          ["H"] = "actions.prev_up",
          ["L"] = "actions.next_up",
          ["P"] = "",
        },

        filter_kind = {
          -- "String",
          "Key",
          "Method",
          "Module",
          "Namespace",
          "Null",
          "Function",
          "Variable",
          "Array",
          "Boolean",
          "Class",
          "Constant",
          "Constructor",
          "Enum",
          "EnumMember",
          "Event",
          "Field",
          "File",
          "Interface",
          "Number",
          "Object",
          "Struct",
          "TypeParameter",
          "Operator",
          "Package",
          "Property",
        },

        link_tree_to_folds = false,
        autojump = true,
        highlight_on_hover = true,
        post_jump_cmd = "",
        -- Ignore diff windows (setting to false will allow aerial in diff windows)
        diff_windows = true,

        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,

        layout = {
          width = 33,
          placement = "edge",
          resize_to_content = false,
          default_direction = "right",
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB,WinSeparator:AerialWinSep",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },

        icons = icons,
        guides = {
          mid_item = "├",
          last_item = "└",
          nested_top = "│",
          whitespace = " ",
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("aerial").setup(vim.tbl_deep_extend("force", opts, {
        get_highlight = function(symbol, is_icon, is_collapsed)
          return "Aerial" .. symbol.kind .. (is_icon and "Icon" or "")
        end,
      }))
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
          -- Skip if current buffer is aerial
          if vim.bo.filetype == "aerial" then
            return
          end
          -- Skip if in special buffers (pickers, prompts, etc)
          local buftype = vim.bo.buftype
          if buftype ~= "" and buftype ~= "acwrite" then
            return
          end
          -- Skip if filetype suggests a picker/special window
          local ft = vim.bo.filetype
          if ft:match("^snacks") or ft:match("^fzf") or ft:match("^telescope") then
            return
          end
          -- Refresh aerial if it's open
          local aerial = require("aerial")
          if aerial.is_open() then
            aerial.refetch_symbols()
          end
        end,
      })
      -- Set Aerial highlights after setup
      vim.api.nvim_set_hl(0, "AerialGuide", { fg = "black" })
      vim.api.nvim_set_hl(0, "AerialGuide1", { fg = "#f38ba8" })
      vim.api.nvim_set_hl(0, "AerialGuide2", { fg = "Blue" })
      vim.api.nvim_set_hl(0, "AerialGuide3", { fg = "#E800E2" })
      vim.api.nvim_set_hl(0, "AerialGuide4", { fg = "Red" })
      vim.api.nvim_set_hl(0, "AerialGuide5", { fg = "#00ED28" })  -- pink
      vim.api.nvim_set_hl(0, "AerialGuide6", { fg = "#bbbbbb" })  -- grey
      vim.api.nvim_set_hl(0, "AerialGuide7", { fg = "#ff5555" })  -- red
      vim.api.nvim_set_hl(0, "AerialGuide8", { fg = "#50fa7b" })  -- green
      vim.api.nvim_set_hl(0, "AerialGuide9", { fg = "#8be9fd" })  -- blue
      vim.api.nvim_set_hl(0, "AerialGuide10", { fg = "#f1fa8c" }) -- yellow
      vim.api.nvim_set_hl(0, "AerialWinSeparator", { fg = "#000000", bg = "NONE" })
      vim.api.nvim_set_hl(0, "AerialNormal", { link = "Normal" })
    end,
  },
  -- edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      local edgy_idx = LazyVim.plugin.extra_idx("ui.edgy")
      local aerial_idx = LazyVim.plugin.extra_idx("editor.aerial")
      if edgy_idx and edgy_idx > aerial_idx then
        LazyVim.warn("The `edgy.nvim` extra must be **imported** before the `aerial.nvim` extra to work properly.", {
          title = "LazyVim",
        })
      end
      opts.left = opts.left or {}
      table.insert(opts.left, {
        title = "Aerial",
        ft = "aerial",
        pinned = true,
        open = "AerialToggle",
      })
    end,
  },
}
