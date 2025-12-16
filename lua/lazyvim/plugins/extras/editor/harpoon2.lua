return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })
    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
  end,
  keys = {
    {
      "<C-S-d>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)

        -- Store existing items (excluding current file)
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add all existing items back
        for _, item in ipairs(items) do
          list:add(item)
        end

        -- Add current file at the end
        list:add({ value = current_file, context = { row = 1, col = 0 } })
      end,
      desc = "harpoon add file at last position",
    },
    {
      "<Del>J",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list()) -- Then open the menu
      end,
      desc = "Harpoon Menu",
    },
    {
      "<leader>J",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list()) -- Then open the menu
      end,
      desc = "Harpoon Menu",
    },

    {
      "<C-h>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "harpoon: select 1",
      mode = { "n", "i", "v", "s", "o" },
    },
    {
      "<a-h>",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "harpoon: select 5",
      mode = { "n", "i", "v", "s", "o" },
    },

    {
      "<c-j>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "harpoon file 3",
      mode = { "n", "i", "v", "s", "o" },
    },
    {
      "<a-j>",
      function()
        require("harpoon"):list():select(6)
      end,
      desc = "harpoon file 6",
      mode = { "n", "i", "v", "s", "o" },
    },

    {
      "<c-k>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "harpoon file 3",
      mode = { "n", "i", "v", "s", "o" },
    },
    {
      "<a-k>",
      function()
        require("harpoon"):list():select(7)
      end,
      desc = "harpoon file 7",
      mode = { "n", "i", "v", "s", "o" },
    },

    {
      "<c-l>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "harpoon file 3",
      mode = { "n", "i", "v", "s", "o" },
    },
    {
      "<a-l>",
      function()
        require("harpoon"):list():select(8)
      end,
      desc = "harpoon file 8",
      mode = { "n", "i", "v", "s", "o" },
    },

    {
      "<C-S-h>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 1

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for _, item in ipairs(items) do
          list:add(item)
        end
      end,
      desc = "harpoon add file at position 1",
    },
    {
      "<a-S-h>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 5

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add items before target position
        for i = 1, target_pos - 1 do
          if items[i] then
            list:add(items[i])
          end
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for i = target_pos, #items do
          if items[i] then
            list:add(items[i])
          end
        end
      end,
      desc = "harpoon add file at position 5",
    },

    {
      "<C-S-j>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 2

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add first item from old list if it exists
        if items[1] then
          list:add(items[1])
          table.remove(items, 1)
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for _, item in ipairs(items) do
          list:add(item)
        end
      end,
      desc = "harpoon add file at position 2",
    },
    {
      "<a-S-j>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 6

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add items before target position
        for i = 1, target_pos - 1 do
          if items[i] then
            list:add(items[i])
          end
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for i = target_pos, #items do
          if items[i] then
            list:add(items[i])
          end
        end
      end,
      desc = "harpoon add file at position 6",
    },

    {
      "<C-S-k>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 3

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add first two items from old list if they exist
        for i = 1, 2 do
          if items[1] then
            list:add(items[1])
            table.remove(items, 1)
          end
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for _, item in ipairs(items) do
          list:add(item)
        end
      end,
      desc = "harpoon add file at position 3",
    },
    {
      "<a-S-k>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 7

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add items before target position
        for i = 1, target_pos - 1 do
          if items[i] then
            list:add(items[i])
          end
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for i = target_pos, #items do
          if items[i] then
            list:add(items[i])
          end
        end
      end,
      desc = "harpoon add file at position 7",
    },

    {
      "<C-S-l>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 4

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add first three items from old list if they exist
        for i = 1, 3 do
          if items[1] then
            list:add(items[1])
            table.remove(items, 1)
          end
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for _, item in ipairs(items) do
          list:add(item)
        end
      end,
      desc = "harpoon add file at position 4",
    },
    {
      "<a-S-l>",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local current_file = vim.api.nvim_buf_get_name(0)
        local target_pos = 8

        -- Store existing items
        local items = {}
        for i = 1, list:length() do
          local item = list:get(i)
          if item and item.value ~= current_file then
            table.insert(items, item)
          end
        end

        -- Clear the list
        for i = list:length(), 1, -1 do
          list:remove_at(i)
        end

        -- Add items before target position
        for i = 1, target_pos - 1 do
          if items[i] then
            list:add(items[i])
          end
        end

        -- Insert current file at target position
        list:add({ value = current_file, context = { row = 1, col = 0 } })

        -- Add remaining items after the target position
        for i = target_pos, #items do
          if items[i] then
            list:add(items[i])
          end
        end
      end,
      desc = "harpoon add file at position 8",
    },
  },
}
