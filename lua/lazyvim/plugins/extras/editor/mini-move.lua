return {
  {
    "nvim-mini/mini.move",
    event = "VeryLazy",
    config = function()
      require('mini.move').setup({
        mappings = {
          left       = 'H',
          down       = 'J',
          up         = 'K',
          right      = 'L',
          line_left  = 'H',
          line_down  = 'J',
          line_up    = 'K',
          line_right = 'L',
        }
      })
    end,
  },
}
