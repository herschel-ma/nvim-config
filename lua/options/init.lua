vim.cmd("filetype plugin indent on")
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.hidden = true
vim.o.whichwrap = "b,s,<,>,[,],h,l"
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.conceallevel = 0
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.timeoutlen = 100
vim.o.clipboard = "unnamedplus"
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.wo.wrap = true -- fold line
vim.wo.number = true
vim.o.cursorline = true
vim.wo.signcolumn = "yes"
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- vim.o.foldmethod = "indent" -- fold indent
vim.wo.foldmethod = "indent"
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.mouse = "a"
vim.o.autoindent = false
vim.o.smartindent = false

-- try copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- set cursorline
function Pain()
  local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#3d5122",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    red = "#6f3328",
    blue = "#51afef"
  }

  local mode_color = {
    n = colors.cyan,
    i = "#669960",
    v = colors.yellow,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    ic = colors.yellow,
    R = colors.red,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    tr = colors.red
  }
  local color = mode_color[vim.api.nvim_get_mode().mode]
  if color == nil then
    color = "NONE"
  end
  -- print(vim.api.nvim_get_mode().mode)
  vim.api.nvim_command("hi! CursorLine guifg=NONE guibg=" .. color)
end

-- vim.api.nvim_command([[autocmd ModeChanged * lua Pain()]])
