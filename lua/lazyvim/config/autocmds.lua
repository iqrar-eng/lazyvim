local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Ajuto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Define highlight groups for different intervals
local ns_id = vim.api.nvim_create_namespace("relative_cursor_intervals")
vim.api.nvim_set_hl(0, "RelativeLineInterval_b", { bg = "#FFFEE8", bold = true })
vim.api.nvim_set_hl(0, "RelativeLineInterval_c", { bg = "#F7F7F7", bold = true })
vim.api.nvim_set_hl(0, "RelativeLineInterval_e", { bg = "#E0FFE2", bold = true })
vim.api.nvim_set_hl(0, "RelativeLineInterval_d", { bg = "#E8FFF8", bold = true })
vim.api.nvim_set_hl(0, "RelativeLineInterval_f", { bg = "#F7F2FF", bold = true })
vim.api.nvim_set_hl(0, "RelativeLineInterval_g", { bg = "#FFF6F0", bold = true })
local function highlight_window(win)
  win = win or vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  local buf = vim.api.nvim_win_get_buf(win)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  local total = vim.api.nvim_buf_line_count(buf)
  local ok, cursor_line = pcall(vim.api.nvim_win_get_cursor, win)
  if not ok then
    return
  end
  cursor_line = cursor_line[1]
  vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
  local map = {
    [7]  = "RelativeLineInterval_b",
    [14] = "RelativeLineInterval_c",
    [21] = "RelativeLineInterval_d",
    [28] = "RelativeLineInterval_f",
    [35] = "RelativeLineInterval_g",
    [42] = "RelativeLineInterval_e",
  }
  for line = 1, total do
    local dist = math.abs(line - cursor_line)
    local hl = map[dist]
    if hl then
      pcall(vim.api.nvim_buf_set_extmark, buf, ns_id, line - 1, 0, {
        line_hl_group = hl,
        hl_eol = true,
        priority = 150,
      })
    end
  end
end
local function highlight_all_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      highlight_window(win)
    end
  end
end
local timer = vim.loop.new_timer()
timer:start(0, 100, vim.schedule_wrap(function()
  highlight_all_windows()
end))
vim.api.nvim_create_autocmd({
  "CursorMoved", "CursorMovedI",
  "WinScrolled", "BufEnter", "WinEnter",
}, {
  callback = function()
    vim.schedule(highlight_all_windows)
  end,
})
vim.schedule(highlight_all_windows)

-- Highlight on yank with custom background - permanent
local yank_ns = vim.api.nvim_create_namespace("yank_highlight")
local last_highlight = nil
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    if last_highlight then
      pcall(vim.api.nvim_buf_clear_namespace, last_highlight.buf, yank_ns, 0, -1)
    end
    local buf = vim.api.nvim_get_current_buf()
    local pos1 = vim.fn.getpos("'[")
    local pos2 = vim.fn.getpos("']")
    last_highlight = { buf = buf }
    for line = pos1[2], pos2[2] do
      local start_col = (line == pos1[2]) and (pos1[3] - 1) or 0
      local end_col = (line == pos2[2]) and pos2[3] or -1
      vim.api.nvim_buf_add_highlight(buf, yank_ns, "YankHighlight", line - 1, start_col, end_col)
    end
  end,
})
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#F2FFF0" })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#F2FFF0" })
  end,
})

-- help windows open in full height
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = function()
    vim.opt_local.winfixheight = true
    vim.cmd("wincmd _")
  end,
})

-- autosave with delay
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
local autosave_timer = nil
local autosave_delay = 1000
local function perform_autosave(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  if not vim.bo[buf].modifiable then return end
  if not vim.bo[buf].modified then return end
  local bufname = vim.api.nvim_buf_get_name(buf)
  if bufname == "" or bufname == nil then return end
  if vim.bo[buf].buftype ~= "" then return end
  local skip_filetypes = { "gitcommit", "gitrebase", "diff" }
  if vim.tbl_contains(skip_filetypes, vim.bo[buf].filetype) then return end
  if vim.fn.filereadable(bufname) == 0 then return end
  if vim.bo[buf].readonly then return end
  if bufname:match("^/tmp/") or bufname:match("%.tmp$") then return end
  pcall(function()
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! noautocmd write")
    end)
  end)
end
vim.api.nvim_create_autocmd(
  { "InsertLeave", "TextChanged", "CursorHoldI" },
  {
    group = autosave_group,
    pattern = "*",
    callback = function(args)
      if autosave_timer then
        autosave_timer:stop()
      end
      autosave_timer = vim.defer_fn(function()
        perform_autosave(args.buf)
      end, autosave_delay)
    end,
  }
)
