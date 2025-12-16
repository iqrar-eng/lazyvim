local M = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end

return {
  "monaqa/dial.nvim",
  recommended = true,
  desc = "Increment and decrement numbers, dates, and more",
  -- stylua: ignore
  keys = {
    { "<C-a>",  function() return M.dial(true) end,        expr = true, desc = "Increment", mode = { "n", "v" } },
    { "<C-x>",  function() return M.dial(false) end,       expr = true, desc = "Decrement", mode = { "n", "v" } },
    { "g<C-a>", function() return M.dial(true, true) end,  expr = true, desc = "Increment", mode = { "n", "x" } },
    { "g<C-x>", function() return M.dial(false, true) end, expr = true, desc = "Decrement", mode = { "n", "x" } },
  },
  opts = function()
    local augend = require("dial.augend")

    local on_off = augend.constant.new({
      elements = { "off", "on" },
      word = true,
      cyclic = true,
    })
    local On_Off = augend.constant.new({
      elements = { "Off", "On" },
      word = true,
      cyclic = true,
    })
    local ON_OFF = augend.constant.new({
      elements = { "OFF", "ON" },
      word = true,
      cyclic = true,
    })

    -- Direction / Position (most used)
    local left_right = augend.constant.new({
      elements = { "left", "right" },
      word = true,
      cyclic = true,
    })
    local Left_Right = augend.constant.new({
      elements = { "Left", "Right" },
      word = true,
      cyclic = true,
    })
    local LEFT_RIGHT = augend.constant.new({
      elements = { "LEFT", "RIGHT" },
      word = true,
      cyclic = true,
    })

    local up_down = augend.constant.new({
      elements = { "up", "down" },
      word = true,
      cyclic = true,
    })
    local Up_Down = augend.constant.new({
      elements = { "Up", "Down" },
      word = true,
      cyclic = true,
    })
    local UP_DOWN = augend.constant.new({
      elements = { "UP", "DOWN" },
      word = true,
      cyclic = true,
    })

    local top_bottom = augend.constant.new({
      elements = { "top", "bottom" },
      word = true,
      cyclic = true,
    })
    local Top_Bottom = augend.constant.new({
      elements = { "Top", "Bottom" },
      word = true,
      cyclic = true,
    })
    local TOP_BOTTOM = augend.constant.new({
      elements = { "TOP", "BOTTOM" },
      word = true,
      cyclic = true,
    })

    local first_last = augend.constant.new({
      elements = { "first", "last" },
      word = true,
      cyclic = true,
    })
    local First_Last = augend.constant.new({
      elements = { "First", "Last" },
      word = true,
      cyclic = true,
    })
    local FIRST_LAST = augend.constant.new({
      elements = { "FIRST", "LAST" },
      word = true,
      cyclic = true,
    })

    -- State / Boolean (critical)
    local true_false = augend.constant.new({
      elements = { "false", "true" },
      word = true,
      cyclic = true,
    })
    local True_False = augend.constant.new({
      elements = { "False", "True" },
      word = true,
      cyclic = true,
    })
    local TRUE_FALSE = augend.constant.new({
      elements = { "FALSE", "TRUE" },
      word = true,
      cyclic = true,
    })

    local enable_disable = augend.constant.new({
      elements = { "disable", "enable" },
      word = true,
      cyclic = true,
    })
    local Enable_Disable = augend.constant.new({
      elements = { "Disable", "Enable" },
      word = true,
      cyclic = true,
    })
    local ENABLE_DISABLE = augend.constant.new({
      elements = { "DISABLE", "ENABLE" },
      word = true,
      cyclic = true,
    })

    local enabled_disabled = augend.constant.new({
      elements = { "disabled", "enabled" },
      word = true,
      cyclic = true,
    })
    local Enabled_Disabled = augend.constant.new({
      elements = { "Disabled", "Enabled" },
      word = true,
      cyclic = true,
    })
    local ENABLED_DISABLED = augend.constant.new({
      elements = { "DISABLED", "ENABLED" },
      word = true,
      cyclic = true,
    })

    -- Visibility / UI
    local show_hide = augend.constant.new({
      elements = { "hide", "show" },
      word = true,
      cyclic = true,
    })
    local Show_Hide = augend.constant.new({
      elements = { "Hide", "Show" },
      word = true,
      cyclic = true,
    })
    local SHOW_HIDE = augend.constant.new({
      elements = { "HIDE", "SHOW" },
      word = true,
      cyclic = true,
    })

    local visible_hidden = augend.constant.new({
      elements = { "hidden", "visible" },
      word = true,
      cyclic = true,
    })
    local Visible_Hidden = augend.constant.new({
      elements = { "Hidden", "Visible" },
      word = true,
      cyclic = true,
    })
    local VISIBLE_HIDDEN = augend.constant.new({
      elements = { "HIDDEN", "VISIBLE" },
      word = true,
      cyclic = true,
    })

    -- Logic / Flow
    local and_or = augend.constant.new({
      elements = { "and", "or" },
      word = true,
      cyclic = true,
    })
    local And_Or = augend.constant.new({
      elements = { "And", "Or" },
      word = true,
      cyclic = true,
    })
    local AND_OR = augend.constant.new({
      elements = { "AND", "OR" },
      word = true,
      cyclic = true,
    })

    -- Min/Max (super common in algorithms, validation, CSS)
    local min_max = augend.constant.new({
      elements = { "max", "min" },
      word = true,
      cyclic = true,
    })
    local Min_Max = augend.constant.new({
      elements = { "Max", "Min" },
      word = true,
      cyclic = true,
    })
    local MIN_MAX = augend.constant.new({
      elements = { "MAX", "MIN" },
      word = true,
      cyclic = true,
    })

    -- Width/Height (CSS, UI, canvas)
    local width_height = augend.constant.new({
      elements = { "height", "width" },
      word = true,
      cyclic = true,
    })
    local Width_Height = augend.constant.new({
      elements = { "Height", "Width" },
      word = true,
      cyclic = true,
    })
    local WIDTH_HEIGHT = augend.constant.new({
      elements = { "HEIGHT", "WIDTH" },
      word = true,
      cyclic = true,
    })

    -- Next/Previous (pagination, navigation)
    local next_prev = augend.constant.new({
      elements = { "prev", "next" },
      word = true,
      cyclic = true,
    })
    local Next_Prev = augend.constant.new({
      elements = { "Prev", "Next" },
      word = true,
      cyclic = true,
    })
    local NEXT_PREV = augend.constant.new({
      elements = { "PREV", "NEXT" },
      word = true,
      cyclic = true,
    })

    -- Previous/Next (full word variant)
    local previous_next = augend.constant.new({
      elements = { "next", "previous" },
      word = true,
      cyclic = true,
    })
    local Previous_Next = augend.constant.new({
      elements = { "Next", "Previous" },
      word = true,
      cyclic = true,
    })
    local PREVIOUS_NEXT = augend.constant.new({
      elements = { "NEXT", "PREVIOUS" },
      word = true,
      cyclic = true,
    })

    -- Before/After (hooks, lifecycle, ordering)
    local before_after = augend.constant.new({
      elements = { "after", "before" },
      word = true,
      cyclic = true,
    })
    local Before_After = augend.constant.new({
      elements = { "After", "Before" },
      word = true,
      cyclic = true,
    })
    local BEFORE_AFTER = augend.constant.new({
      elements = { "AFTER", "BEFORE" },
      word = true,
      cyclic = true,
    })

    -- Old/New (migrations, versioning, comparisons)
    local old_new = augend.constant.new({
      elements = { "new", "old" },
      word = true,
      cyclic = true,
    })
    local Old_New = augend.constant.new({
      elements = { "New", "Old" },
      word = true,
      cyclic = true,
    })
    local OLD_NEW = augend.constant.new({
      elements = { "NEW", "OLD" },
      word = true,
      cyclic = true,
    })

    local css_position = augend.constant.new({
      elements = {
        "absolute",
        "relative",
        "fixed",
        "sticky",
      },
      word = true,
      cyclic = true,
    })

    -- Dev Verbs
    local add_remove = augend.constant.new({
      elements = { "remove", "add" },
      word = true,
      cyclic = true,
    })
    local Add_Remove = augend.constant.new({
      elements = { "Remove", "Add" },
      word = true,
      cyclic = true,
    })
    local ADD_REMOVE = augend.constant.new({
      elements = { "REMOVE", "ADD" },
      word = true,
      cyclic = true,
    })

    local start_stop_end = augend.constant.new({
      elements = { "start", "stop", "end" },
      word = true,
      cyclic = true,
    })
    local Start_Stop_End = augend.constant.new({
      elements = { "Start", "Stop", "End" },
      word = true,
      cyclic = true,
    })
    local START_STOP_END = augend.constant.new({
      elements = { "START", "STOP", "END" },
      word = true,
      cyclic = true,
    })

    -- UI / CSS
    local horizontal_vertical = augend.constant.new({
      elements = { "vertical", "horizontal" },
      word = true,
      cyclic = true,
    })
    local Horizontal_Vertical = augend.constant.new({
      elements = { "Vertical", "Horizontal" },
      word = true,
      cyclic = true,
    })
    local HORIZONTAL_VERTICAL = augend.constant.new({
      elements = { "VERTICAL", "HORIZONTAL" },
      word = true,
      cyclic = true,
    })

    local row_column = augend.constant.new({
      elements = { "column", "row" },
      word = true,
      cyclic = true,
    })
    local Row_Column = augend.constant.new({
      elements = { "Column", "Row" },
      word = true,
      cyclic = true,
    })
    local ROW_COLUMN = augend.constant.new({
      elements = { "COLUMN", "ROW" },
      word = true,
      cyclic = true,
    })

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local disable_enable = augend.constant.new({
      elements = { "disable", "enable" },
      word = true,
      cyclic = true,
    })
    local Disable_Enable = augend.constant.new({
      elements = { "Disable", "Enable" },
      word = true,
      cyclic = true,
    })
    local DISABLE_ENABLE = augend.constant.new({
      elements = { "DISABLE", "ENABLE" },
      word = true,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local yes_no = augend.constant.new({
      elements = { "no", "yes" },
      word = true,
      cyclic = true,
    })
    local Yes_No = augend.constant.new({
      elements = { "No", "Yes" },
      word = true,
      cyclic = true,
    })
    local YES_NO = augend.constant.new({
      elements = { "NO", "YES" },
      word = true,
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      dials_by_ft = {
        css = "css",
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        sass = "css",
        scss = "css",
        python = "python",
      },
      groups = {
        default = {
          -- Direction / Position
          left_right,
          Left_Right,
          LEFT_RIGHT,
          up_down,
          Up_Down,
          UP_DOWN,
          top_bottom,
          Top_Bottom,
          TOP_BOTTOM,
          first_last,
          First_Last,
          FIRST_LAST,

          -- State / Boolean
          true_false,
          True_False,
          TRUE_FALSE,
          enable_disable,
          Enable_Disable,
          ENABLE_DISABLE,
          enabled_disabled,
          Enabled_Disabled,
          ENABLED_DISABLED,
          disable_enable,
          Disable_Enable,
          DISABLE_ENABLE,

          -- Visibility / UI
          show_hide,
          Show_Hide,
          SHOW_HIDE,
          visible_hidden,
          Visible_Hidden,
          VISIBLE_HIDDEN,

          -- Logic / Flow
          and_or,
          And_Or,
          AND_OR,
          logical_alias,

          -- Min/Max
          min_max,
          Min_Max,
          MIN_MAX,

          -- Width/Height
          width_height,
          Width_Height,
          WIDTH_HEIGHT,

          -- Next/Previous
          next_prev,
          Next_Prev,
          NEXT_PREV,
          previous_next,
          Previous_Next,
          PREVIOUS_NEXT,

          -- Before/After
          before_after,
          Before_After,
          BEFORE_AFTER,

          -- Old/New
          old_new,
          Old_New,
          OLD_NEW,

          -- Dev Verbs
          add_remove,
          Add_Remove,
          ADD_REMOVE,
          start_stop_end,
          Start_Stop_End,
          START_STOP_END,

          -- UI / CSS
          css_position,
          horizontal_vertical,
          Horizontal_Vertical,
          HORIZONTAL_VERTICAL,
          row_column,
          Row_Column,
          ROW_COLUMN,

          yes_no,
          Yes_No,
          YES_NO,

          on_off,
          On_Off,
          ON_OFF,

          augend.integer.alias.decimal,     -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
          augend.integer.alias.hex,         -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"],    -- date (2022/02/19, etc.)
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,

        },
        vue = {
          augend.constant.new({ elements = { "let", "const" } }),
          augend.hexcolor.new({ case = "lower" }),
          augend.hexcolor.new({ case = "upper" }),
        },
        typescript = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        css = {
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.constant.new({
            elements = { "[ ]", "[x]" },
            word = false,
            cyclic = true,
          }),
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.semver.alias.semver, -- versioning (v1.1.2)
        },
        lua = {
          augend.constant.new({
            elements = { "and", "or" },
            word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
        },
        python = {
          augend.constant.new({
            elements = { "and", "or" },
          }),
        },
      },
    }
  end,
  config = function(_, opts)
    -- copy defaults to each group
    for name, group in pairs(opts.groups) do
      if name ~= "default" then
        vim.list_extend(group, opts.groups.default)
      end
    end
    require("dial.config").augends:register_group(opts.groups)
    vim.g.dials_by_ft = opts.dials_by_ft
  end,
}
