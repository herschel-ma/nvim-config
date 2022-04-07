require("plugins")
require("options")
require("keybindings")
require("staline-config")
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
-- colorscheme set
-- vim.cmd('colorscheme nord')

vim.api.nvim_exec(
  [[
function! s:AutoChangeColorStyle()
    let hour = strftime("%H")
    if 6 <= hour && hour < 18
        let g:tokyonight_style = "day"
    else
        let g:tokyonight_style = "night"
    endif
endfunction
call s:AutoChangeColorStyle()
]],
  false
)

local hour = tonumber(vim.fn.strftime("%H"))
if hour > 6 and hour < 18 then
  vim.g.tokyonight_style = "day"
else
  vim.g.tokyonight_style = "night"
end
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}

-- require("monokai").setup {}
-- require("monokai").setup {palette = require("monokai").pro}
require("monokai").setup {palette = require("monokai").soda}
--require("nightfox").load("randfox")
vim.cmd("colorscheme tokyonight")

-- gui-neovide
-- vim.o.guifont = "JetBrainsMono Nerd Font:h12"
vim.o.guifont = "GoMono Nerd Font Mono Bold :h12"
vim.g.neovide_transparency = 1
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_length = 0.8
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_speed = 13.0
vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true

-- temporary set python interceptor /usr/bin/python3
vim.g.python_path = "/usr/bin/python3"

-- herschel
-- 2021年 10月 16日 星期六 17:47:04 CST
