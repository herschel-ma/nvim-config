require("plugins")
require("options")
require("keybindings")
require("nvim-treesitter-config")
require("nvim-tree-config")
require("nvim-autopairs-config")
require("nvim-transparent-config")
require("which-key-config")
require("telescope-config")
require("nvim-lsp-config")
require("nvim-dashboard-config")
require("cmp-tabnine-config")
require("formatter-config")
require("indent-blankline-config")
require("toggleterminal-config")
require("nvim-dap-config")
require("nvim-dap-virtual-text-config")
require("nvim-dap-ui-config")
require("nvim-directory-config")
require("nvim-notify-config")
require("nvim-colorscheme-config")
require("bufferline-config")
require("lualine-config")
require("winbar-config")
-- colorscheme set
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}

-- require("monokai").setup {}
-- require("monokai").setup {palette = require("monokai").pro}
-- require("monokai").setup {palette = require("monokai").soda}
--require("nightfox").load("randfox")
-- To enable transparency
if vim.fn.has("gui_running") == 0 then
  vim.g.solarized_termtrans = 0
else
  vim.g.solarized_termtrans = 1
end
vim.g.solarized_diffmode = "normal"
vim.g.solarized_statusline = "normal"
-- vim.cmd [[colorscheme rvcs]]
-- vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme solarized-low")
-- Example config in Lua
require("github-theme").setup(
  {
    -- theme_style = "dimmed",
    theme_style = "dark_default",
    comment_style = "italic",
    keyword_style = "italic",
    function_style = "italic",
    variable_style = "italic",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},
    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = {hint = "orange", error = "#ff0000"},
    -- Overwrite the highlight groups
    overrides = function(c)
      return {
        htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
        DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
        -- this will remove the highlight groups
        TSField = {}
      }
    end
  }
)

-- gui-neovide
vim.o.guifont = "CaskaydiaCove Nerd Font Regular"
vim.g.neovide_transparency = 0.8
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_length = 0.8
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_speed = 13.0
vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true

-- gui-nvim-gtk
if vim.fn.has("g:GtkGuiLoaded") then
  vim.rpcnotify(1, "Gui", "Font", "CaskaydiaCove Nerd Font Regular 12")
end

-- temporary set python interceptor /usr/bin/python3
vim.g.python_path = "/usr/bin/python3"

-- herschel
-- 2021年 10月 16日 星期六 17:47:04 CST
