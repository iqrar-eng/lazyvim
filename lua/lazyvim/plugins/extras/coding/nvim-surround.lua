-- Fast and feature-rich surround actions. For text that includes
-- surrounding characters like brackets or quotes, this allows you
-- to select the text inside, change or modify the surrounding characters,
-- and more.
return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({

        move_cursor = "sticky",

        keymaps = {
          insert = "<C-g>",
          insert_line = "<C-b>",
          normal = "<CR>",
          visual = "<CR>",
          normal_line = " <CR>",
          visual_line = " <CR>",
          normal_cur = "<CR>d",
          normal_cur_line = "<CR>s",
          delete = "d<CR>",
          change = "f<CR>",
          change_line = "s<CR>",
        },

      })
    end,
  }
}
