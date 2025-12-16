if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "snacks"
end

---@module 'snacks'

---@type LazyPicker
local picker = {
  name = "snacks",
  commands = {
    files = "files",
    live_grep = "grep",
    oldfiles = "recent",
  },

  ---@param source string
  ---@param opts? snacks.picker.Config
  open = function(source, opts)
    return Snacks.picker.pick(source, opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

return {
  desc = "Fast and modern file picker",
  recommended = true,
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      picker = {
        sources = {
          buffers = {
            finder = { "buffers", "recent" },
            format = "buffer",
            hidden = true,
            unloaded = true,
            sort_lastused = true,
            transform = "unique_file",
          },
          lines = {
            layout = {
              preview = "top",
              preset = "left_preview",
            },
          },
          files = {
            hidden = true,
          },
          grep_word = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
        formatters = {
          file = {
            filename_first = false, -- display filename before the file path
            truncate = 80,          -- truncate the file path to (roughly) this length
            filename_only = false,  -- only show the filename
            icon_width = 2,         -- width of the icon (in characters)
            git_status_hl = true,   -- use the git status highlight group for the filename
          },
        },
        layout = "left_preview",
        layouts = {
          left_preview = {
            layout = {
              reverse = true,
              backdrop = false,
              width = 0,
              min_width = 0,
              height = 0,
              box = "vertical",
              { win = "preview", height = 0.7,   border = "none" },
              {
                win = "input",
                height = 1,
                title = "{title} {live} {flags}",
              },
              { win = "list",    border = "none" },
            },
          },
        },
        actions = {
          flash = function(picker)
            require("flash").jump({
              pattern = "$",
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
        },
        win = {
          -- input window
          input = {
            keys = {
              ["<c-f>"] = { "flash", mode = { "n", "i" } },
              ["<c-h>"] = { "toggle_preview", mode = { "i", "n" } },
              ["<c-d>"] = { "focus_preview", mode = { "i", "n" } },
              ["<c-l>"] = { "focus_list", mode = { "i", "n" } },
              ["<c-s>"] = { "toggle_live", mode = { "i", "n" } },
              ["<c-r>"] = { "insert_cWORD", mode = { "i", "n" } },
              ["<c-e>"] = { "insert_cword", mode = { "i", "n" } },

              ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
              ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },
              ["<C-Home>"] = { "list_top", mode = { "i", "n" } },
              ["<C-End>"] = { "list_bottom", mode = { "i", "n" } },
              ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },

              ["<c-u>"] = { "<c-u>", mode = { "i" }, expr = true, desc = "delete word" },
              ["<a-f>"] = {
                function()
                  local col = vim.fn.col('.')
                  if col == 1 then
                    return '<esc>"zd$a'
                  else
                    return '<esc>l"zd$a'
                  end
                end,
                mode = { "i" },
                expr = true,
                desc = "delete word"
              },
              ["<a-s>"] = {
                function()
                  local col = vim.fn.col('.')
                  if col == 1 then
                    return '<esc>"zdei'
                  else
                    return '<esc>l"zdei'
                  end
                end,
                mode = { "i" },
                expr = true,
                desc = "delete word"
              },
            },
          },
          -- result list window
          list = {
            keys = {
              ["<c-h>"] = "toggle_preview",
              ["<c-d>"] = "focus_input",
              ["<c-l>"] = "focus_input",
              ["<c-f>"] = "toggle_preview",
              ["<c-c>"] = "close",

              ["<PageUp>"] = "list_scroll_up",
              ["<PageDown>"] = "list_scroll_down",
              ["<C-Home>"] = "list_top",
              ["<C-End>"] = "list_bottom",
              ["<c-k>"] = "preview_scroll_up",
              ["<c-j>"] = "preview_scroll_down",
            },
          },
          -- preview window
          preview = {
            keys = {
              ["<c-h>"] = "toggle_preview",
              ["<c-d>"] = "focus_input",
              ["<c-l>"] = "focus_input",
              ["<c-f>"] = "toggle_preview",
              ["<c-c>"] = "close",
            },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {

      { "<leader>m",     function() Snacks.picker.help() end,                        desc = "Help Pages",                          mode = { "n", "x" }, },
      { "m",             function() Snacks.picker.man() end,                         desc = "Man Pages",                           mode = { "n", "x" }, },

      { "<leader>j",     function() Snacks.picker.buffers() end,                     desc = "Buffers & Recent Files",              mode = { "n", "x" }, },
      { "<BS><Down>",    function() Snacks.picker.grep_buffers() end,                desc = "Grep Open Buffers",                   mode = { "n", "x" }, },

      { "<leader>k",     LazyVim.pick("files", { root = false }),                    desc = "Find Files (cwd)",                    mode = { "n", "x" }, },
      { "<BS><Up>",      LazyVim.pick("live_grep", { root = false }),                desc = "Grep (cwd)",                          mode = { "n", "x" }, },

      { "<leader>l",     LazyVim.pick("files"),                                      desc = "Find Files (Root Dir)",               mode = { "n", "x" }, },
      { "<BS><Right>",   LazyVim.pick("grep"),                                       desc = "Grep (Root Dir)",                     mode = { "n", "x" }, },

      { "<leader>gg",    function() Snacks.picker.git_files() end,                   desc = "Find Files (git-files)",              mode = { "n", "x" }, },
      { "<leader>gd",    function() Snacks.picker.git_diff() end,                    desc = "Git Diff (hunks)",                    mode = { "n", "x" }, },
      { "<leader>gD",    function() Snacks.picker.git_diff({ base = "origin" }) end, desc = "Git Diff (origin)",                   mode = { "n", "x" }, },
      { "<leader>gs",    function() Snacks.picker.git_status() end,                  desc = "Git Status",                          mode = { "n", "x" }, },
      { "<leader>gS",    function() Snacks.picker.git_stash() end,                   desc = "Git Stash",                           mode = { "n", "x" }, },

      { "<BS><Left>",    function() Snacks.picker.lines() end,                       desc = "Buffer Lines",                        mode = { "n", "x" }, },
      { "<leader>:",     function() Snacks.picker.command_history() end,             desc = "Command History",                     mode = { "n", "x" }, },

      { "<leader>K",     LazyVim.pick("grep_word", { root = false }),                desc = "Visual selection or word (cwd)",      mode = { "n", "x" }, },
      { "<Del>K",        LazyVim.pick("grep_word", { root = false }),                desc = "Visual selection or word (cwd)",      mode = { "n", "x" }, },

      { "<leader>L",     LazyVim.pick("grep_word"),                                  desc = "Visual selection or word (Root Dir)", mode = { "n", "x" }, },
      { "<Del>L",        LazyVim.pick("grep_word"),                                  desc = "Visual selection or word (Root Dir)", mode = { "n", "x" }, },

      { "<leader>u",     function() Snacks.picker.undo() end,                        desc = "Undotree",                            mode = { "n", "x" }, },
      { "<leader><tab>", function() Snacks.picker.resume() end,                      desc = "Resume",                              mode = { "n", "x" }, },
      { "<leader>a",     function() Snacks.picker.icons() end,                       desc = "Icons",                               mode = { "n", "x" }, },
      { '<leader>/',     function() Snacks.picker.search_history() end,              desc = "Search History",                      mode = { "n", "x" }, },

      { "<leader>fp",    function() Snacks.picker.lazy() end,                        desc = "Search for Plugin Spec",              mode = { "n", "x" }, },
      { "<leader>fg",    function() Snacks.picker.diagnostics() end,                 desc = "Diagnostics",                         mode = { "n", "x" }, },
      { "<leader>fb",    function() Snacks.picker.diagnostics_buffer() end,          desc = "Buffer Diagnostics",                  mode = { "n", "x" }, },
      { "<leader>fa",    function() Snacks.picker.keymaps() end,                     desc = "Keymaps",                             mode = { "n", "x" }, },
      { "<leader>ff",    function() Snacks.picker.highlights() end,                  desc = "Highlights",                          mode = { "n", "x" }, },

      { "<Del>H",        function() Snacks.picker.jumps() end,                       desc = "jumps",                               mode = { "n", "x" }, },
      { "<leader>H",     function() Snacks.picker.jumps() end,                       desc = "jumps",                               mode = { "n", "x" }, },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          -- stylua: ignore
          keys = {
            { "gd",  function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition",       has = "definition" },
            { "gr",  function() Snacks.picker.lsp_references() end,       nowait = true,                  desc = "References" },
            { "gI",  function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
            { "gy",  function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "gai", function() Snacks.picker.lsp_incoming_calls() end,   desc = "C[a]lls Incoming",      has = "callHierarchy/incomingCalls" },
            { "gao", function() Snacks.picker.lsp_outgoing_calls() end,   desc = "C[a]lls Outgoing",      has = "callHierarchy/outgoingCalls" },
            -- { "<leader>f<esc>", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
          },
        },
      },
    },
  },
}
