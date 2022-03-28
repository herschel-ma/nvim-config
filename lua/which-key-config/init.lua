-- tips:
-- 1. S + word 可以向上查找字符串
-- 2. s/t + single word 可以向下查找字符串
local wk = require("which-key")
local mappings = {
  q = {":q<CR>", "Quit"},
  w = {":w<CR>", "Save"},
  Q = {":wq<CR>", "Save and Quit"},
  x = {"<cmd>bdelete<CR>", "Close"},
  E = {"<cmd>e ~/.config/nvim/init.lua<CR>", "Edit config"},
  t = {
    name = "Telescope",
    f = {"<cmd>Telescope find_files<CR>", "Find Files"},
    r = {"<cmd>Telescope live_grep<CR>", "Live Grep"},
    l = {"<cmd>Telescope diagnostics<CR>", "List Diagnostics"} -- and then <C-q> will pushs problems to quickfix.
  },
  l = {
    name = "LSP",
    i = {":LspInfo<CR>", "Connected Language Server"},
    I = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation"},
    A = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder"},
    R = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder"},
    l = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folders"},
    D = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
    n = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
    a = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action"},
    e = {"<cmd>lua vim.diagnostic.open_float()<CR>", "Show Line Diagnostics"},
    q = {"<cmd>lua vim.diagnostic.set_loclist()<CR>", "Show Loclist"},
    K = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
    d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition"},
    r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Go To References"},
    k = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help"},
    f = {"<cmd>lua vim.lsp.buf.formatting()<CR>", "Format"}
  },
  v = {":VsnipOpen<CR>", "Open Vsnip Config"}
}

local opts = {prefix = "<leader>"}
wk.register(mappings, opts)
wk.register(
  {
    ["<leader>l["] = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go To Previous Diagnostic"},
    ["<leader>l]"] = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "Go To Next Diagnostic"}
  }
)
