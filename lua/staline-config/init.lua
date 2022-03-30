vim.opt.laststatus = 2
vim.opt.showtabline = 2
require "staline".setup {
  sections = {
    left = {
      "- ",
      "-mode",
      "left_sep_double",
      "file_name",
      "  ",
      "branch"
    },
    mid = {"lsp", "lsp_name"},
    right = {
      "file_size",
      "",
      "cool_symbol",
      " ",
      vim.bo.fileencoding:upper(),
      "right_sep_double",
      "-line_column"
    }
  },
  defaults = {
    cool_symbol = "  ",
    left_separator = "",
    right_separator = "",
    bg = "#303030",
    full_path = false,
    branch_symbol = " "
  },
  mode_colors = {
    n = "#986fec",
    i = "#e86671",
    ic = "#e86671",
    c = "#e27d60"
  }
}
require "stabline".setup {
  style = "slant",
  bg = "#986fec",
  fg = "#303030",
  stab_right = "",
  font_active = "bold",
  exclude_fts = {"NvimTree", "dashboard", "lir"},
  stab_start = "",
  stab_end = ""
}
