local wk = require("which-key")
local mappings = {
  q = {":q<CR>", "Quit"},
  w = {":w<CR>", "Save"},
  Q = {":wq<CR>", "Save and Quit"},
  x = {":bdelete<CR>", "Close"},
  E = {":e ~/.config/nvim/init.lua<CR>", "Edit config"},
  f = {":Telescope find_files<CR>", "Telescope Find Files"},
  r = {":Telescope live_grep<CR>", "Telescope Live Grep"},
  l = {
    name = "LSP",
    i = {":LspInfo<CR>", "Connected Language Server"},
    I = {":LspInfo<CR>", "<cmd>lua vim.lsp.buf.implementation()<CR>"},
    A = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder"},
    R = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder"},
    l = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folders"},
    D = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
    n = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
    a = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action"},
    e = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show Line Diagnostics"},
    q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Show Loclist"},
    K = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
    d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition"},
    r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Go To References"},
    k = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help"},
    f = {"<cmd>lua vim.lsp.buf.formatting()<CR>", "Format"},
    m = {
      name = "diagnostic",
      j = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},
      k = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"}
    }
  },
  v = {":VsnipOpen<CR>", "Open Vsnip Config"}
}

local opts = {prefix = "<leader>"}
wk.register(mappings, opts)
