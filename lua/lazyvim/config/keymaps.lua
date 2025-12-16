-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-N
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", " gg", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "Lazygit (Root Dir)" })
  vim.keymap.set("n", " gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
end
vim.keymap.set("n", " gL", function()
  Snacks.picker.git_log()
end, { desc = "Git Log (cwd)" })
vim.keymap.set("n", " gb", function()
  Snacks.picker.git_log_line()
end, { desc = "Git Blame Line" })
vim.keymap.set("n", " gf", function()
  Snacks.picker.git_log_file()
end, { desc = "Git Current File History" })
vim.keymap.set("n", " gl", function()
  Snacks.picker.git_log({ cwd = LazyVim.root.git() })
end, { desc = "Git Log" })
vim.keymap.set({ "n", "x" }, " gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
vim.keymap.set({ "n", "x" }, " gY", function()
  Snacks.gitbrowse({
    open = function(url)
      vim.fn.setreg("+", url)
    end,
    notify = false,
  })
end, { desc = "Git Browse (copy)" })

vim.keymap.set("n", "<c-d>", "<C-^>", { noremap = true, silent = true })
vim.keymap.set("x", "<c-d>", "<Esc><C-^>gv", { noremap = true, silent = true })
vim.keymap.set("i", "<c-d>", "<Esc><C-^>a", { noremap = true, silent = true })
vim.keymap.set("o", "<c-d>", "<Esc><C-^>", { noremap = true, silent = true })

vim.keymap.set({ 'n', 'x', 'o' }, '|<Left>', 'mh', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '|<Down>', 'mj', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '|<Up>', 'mk', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '|<Right>', 'ml', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<Left>', "'h", { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<Down>', "'j", { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<Up>', "'k", { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<Right>', "'l", { noremap = true, silent = true })

vim.keymap.set("n", "-", function()
  local count = vim.v.count1
  vim.cmd('normal! mz' .. count .. 'J`z')
end, { noremap = true, silent = true })
vim.keymap.set("n", "_", "K<cmd>wincmd _<CR>", { noremap = true, silent = true })

vim.keymap.set({ 'n', 'i', 'x', 'o' }, '<c-Home>', 'gg<Home>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'x', 'o' }, '<c-c>', '<cmd>q<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'i', 'x', 'o' }, '<c-q>', '<cmd>wqa<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set('i', '<c-Esc>', '<c-q>', { noremap = true, silent = true })
vim.keymap.set("n", " X", '"zX')
vim.keymap.set("n", "<Del>X", '"zX')
vim.keymap.set("n", " x", '"zx')
vim.keymap.set({ "n", "x" }, " D", '"zD')
vim.keymap.set({ "n", "x" }, "<Del>D", '"zD')
vim.keymap.set({ "n", "x" }, " d", '"zd')
vim.keymap.set({ "n", "o", "x" }, "s", 'y')
vim.keymap.set({ "n", "x" }, "S", 'y$')
vim.keymap.set({ "n", "x" }, " s", '"zy')
vim.keymap.set({ "n", "x" }, " S", '"zy$')
vim.keymap.set({ "n", "x" }, "<Del>S", '"zy$')
vim.keymap.set({ "n", "x" }, " c", '"zc')
vim.keymap.set({ "n", "x" }, "<Del>C", '"zc$')
vim.keymap.set({ "n", "x" }, " C", '"zc$')
vim.keymap.set({ "n", "x" }, "<Del>P", '"zP')
vim.keymap.set({ "n", "x" }, " p", '"zp')
vim.keymap.set("n", " c ", '"zcc')
vim.keymap.set("n", " s ", '"zyy')
vim.keymap.set({ 'n', 'x', 'o' }, ".", "<Esc>s<Tab>", { remap = true })
vim.keymap.set("n", " d ", '"zdd')
vim.keymap.set("n", "d ", "dd", { noremap = true, silent = true })
vim.keymap.set("n", "s ", "yy", { noremap = true, silent = true })
vim.keymap.set("n", "c ", "cc", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, " v", "<C-v>")
vim.keymap.set("n", "<tab>", ".", { noremap = true })
vim.keymap.set("n", "<c-e>", "<c-i>")
vim.keymap.set('n', 'j', "v:count > 1 ? \"m'\" . v:count . 'j' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count > 1 ? \"m'\" . v:count . 'k' : 'k'", { expr = true, silent = true })
vim.keymap.set("i", "<C-x>", "<c-y>", { noremap = true })
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
vim.keymap.set({ "n", "o", "x" }, "$", 'zb')
vim.keymap.set({ "n", "o", "x" }, "'", 'zt')
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("n", " O", function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)")
  vim.cmd("'[")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Del>O", function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)")
  vim.cmd("'[")
end, { noremap = true, silent = true })
vim.keymap.set("n", " o", function()
  vim.cmd("put =repeat(nr2char(10), v:count1)")
end, { noremap = true, silent = true })
vim.keymap.set("n", "y", "gc", { remap = true })
vim.keymap.set({ "o", "x" }, "y", "<cmd>normal gcc<cr>")
vim.keymap.set({ "n", "o", "x" }, "Y", "<cmd>normal gcc<cr>")
vim.keymap.set("n", "y ", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "yl", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("c", "<a-s>", '<c-f>"zde<C-c>', { noremap = true })
vim.keymap.set("i", "<a-s>", function()
  local col = vim.fn.col('.')
  if col == 1 then
    return '<esc>"zdei'
  else
    return '<esc>l"zdei'
  end
end, { expr = true, noremap = true })
vim.keymap.set("i", "<a-f>", function()
  local col = vim.fn.col('.')
  if col == 1 then
    return '<esc>"zd$a'
  else
    return '<esc>l"zd$a'
  end
end, { expr = true, noremap = true })
vim.keymap.set("c", "<a-f>", '<c-f>"zD<C-c>', { noremap = true })

for _, mode in ipairs({ "n", "v", "x", "o", "i" }) do
  vim.keymap.set(mode, "<C-PageDown>", function()
    local count = vim.v.count1
    local was_insert = vim.fn.mode() == "i"
    if was_insert then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end
    vim.cmd("wincmd h")
    vim.cmd("normal! " .. count .. "j")
    vim.api.nvim_input("<CR>")
    if was_insert then
      vim.schedule(function()
        vim.cmd("startinsert")
      end)
    end
  end, {})
  vim.keymap.set(mode, "<C-PageUp>", function()
    local count = vim.v.count1
    local was_insert = vim.fn.mode() == "i"
    if was_insert then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end
    vim.cmd("wincmd h")
    vim.cmd("normal! " .. count .. "k")
    vim.api.nvim_input("<CR>")
    if was_insert then
      vim.schedule(function()
        vim.cmd("startinsert")
      end)
    end
  end, {})
end
for _, mode in ipairs({ "n", "v", "x", "o" }) do
  vim.keymap.set(mode, "G", function()
    vim.cmd("normal! mx")
    vim.cmd("wincmd h")
    vim.cmd("normal P")
  end, {})
end

vim.keymap.set('n', ' fn', function()
  vim.opt_local.number = not vim.opt_local.number:get()
  vim.defer_fn(function()
    vim.cmd('normal! \x1e\x1e') --hex code for <c-^> key
  end, 50)
end, { desc = "Toggle Line Numbers" })
Snacks.toggle.option("spell", { name = "Spelling" }):map(" fs")
Snacks.toggle.diagnostics():map(" fd")
Snacks.toggle.option("wrap", { name = "Wrap" }):map(" fw")
Snacks.toggle.option("conceallevel",
  { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map(" fz")
Snacks.toggle.profiler():map(" fu")
Snacks.toggle.profiler_highlights():map(" fy")
if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map(" fi")
end
LazyVim.format.snacks_toggle():map(" fq")
vim.keymap.set({ "n", "x" }, "z", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
vim.keymap.set(
  "n",
  " fr",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)
vim.keymap.set("n", " fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
vim.keymap.set("n", " fc", "<cmd>w<CR><cmd>source %<CR>", { silent = true, desc = "Save and source current file" })
vim.keymap.set("n", " y", "<cmd>Lazy<CR>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v", "x" }, " h", function()
  local current_win = vim.api.nvim_get_current_win()
  local mode = vim.api.nvim_get_mode().mode
  local was_visual = mode:match("[vVxsS\22]")
  if was_visual then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "n", true)
    vim.defer_fn(function() end, 10) -- Small delay to ensure mode transition
  end
  local neo_tree_win = nil
  local aerial_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "neo-tree" then
      neo_tree_win = win
    elseif ft == "aerial" then
      aerial_win = win
    end
  end
  if neo_tree_win then
    -- Switch from Neo-tree to Aerial
    local neo_tree_width = vim.api.nvim_win_get_width(neo_tree_win)
    require("neo-tree.command").execute({ action = "close" })
    vim.cmd("AerialOpen left")
    local new_aerial_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")
      if ft == "aerial" then
        new_aerial_win = win
        break
      end
    end
    if new_aerial_win then
      pcall(vim.api.nvim_win_set_width, new_aerial_win, neo_tree_width)
    end
  elseif aerial_win then
    -- Switch from Aerial to Neo-tree
    local aerial_width = vim.api.nvim_win_get_width(aerial_win)
    vim.cmd("AerialClose")
    require("neo-tree.command").execute({ toggle = false, dir = vim.fn.expand("~") })
    -- Find the newly opened Neo-tree window
    vim.defer_fn(function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "neo-tree" then
          pcall(vim.api.nvim_win_set_width, win, aerial_width)
          break
        end
      end
    end, 50)
  else
    -- Open Neo-tree if neither is open
    require("neo-tree.command").execute({ toggle = false, dir = vim.fn.expand("~") })
  end
  -- Restore focus and visual selection
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(current_win) then
      local current_buf = vim.api.nvim_win_get_buf(current_win)
      local current_ft = vim.api.nvim_buf_get_option(current_buf, "filetype")
      if current_ft ~= "neo-tree" and current_ft ~= "aerial" then
        vim.api.nvim_set_current_win(current_win)
        if was_visual then
          vim.schedule(function()
            vim.cmd("normal! gv")
          end)
        end
      end
    end
  end)
end, { desc = "Toggle Neo-tree/Aerial" })

-- substitute word_under_cursor in whole file
vim.keymap.set("n", " r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- substitute visual_selection in whole file
vim.keymap.set("x", " r", '"sy:%s/<C-r>s/<C-r>s/gI<Left><Left><Left>')
-- substitute copied_word in visual selection
vim.keymap.set("x", " i", ":s/<C-r>=escape(@*, '/\\')<CR>/<C-r>=escape(@*, '/\\')<CR>/gI<Left><Left><Left>")

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
