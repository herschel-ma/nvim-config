vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = false}
local optsNoremap = {noremap = true, silent = false}
local optsSilent = {silent = false}
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)
-- nvim-tree-keybindings
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- 持续缩进 excellent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("x", "K", ":move '<-2<CR>gv-gv'", opts)
map("x", "J", ":move '>+1<CR>gv-gv'", opts)

map("n", "L", "$", opts)
map("n", "H", "^", opts)

map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
-- makrdown preview
map("v", "<F2>", ":Glow<CR>", opts)

-- more lsp-config here: https://rishabhrd.github.io/jekyll/update/2020/09/19/nvim_lsp_config.html
-- 2021年 10月 15日 星期五 17:00:59 CST
-- herschel
