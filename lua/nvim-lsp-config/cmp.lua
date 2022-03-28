vim.g.completeopt = "menu,menuone,noselect,noinsert"
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
-- Setup nvim-cmp.
local cmp = require "cmp"
-- lspkind
local lspkind = require "lspkind"
local source_mapping = ({
  nvim_lsp = "[LSP]",
  buffer = "[Buffer]",
  vsnip = "[VSnip]",
  luasnip = "[LuaSnip]",
  nvim_lua = "[Lua]",
  latex_symbols = "[Latex]",
  Path = "[Path]",
  cmp_tabnine = "[TN]"
})

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}
cmp.setup {
  view = {entries = "custom"},
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping(
      function(fallback)
        local copilot_keys = vim.fn["copilot#Accept"]()
        if copilot_keys ~= "" then
          vim.api.nvim_feedkeys(copilot_keys, "i", true)
        else
          fallback()
        end
      end
    ),
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end,
      {"i", "s"}
    ),
    ["<S-Tab>"] = cmp.mapping(
      function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end,
      {"i", "s"}
    )
  },
  sources = {
    {
      name = "nvim_lsp",
      keyword_length = 1
    },
    -- For vsnip user.
    {name = "vsnip"},
    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },
    {name = "nvim_lua"},
    {name = "buffer"},
    {name = "cmp_tabnine"}
  },
  formatting = {
    format = lspkind.cmp_format(
      {
        mode = "symbol_text", -- show only symbol annotations
        -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        menu = source_mapping,
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(_, vim_item)
          vim_item.kind = kind_icons[vim_item.kind] or ""
          return vim_item
        end
      }
    )
  },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_partial_matching = false
  }
}

cmp.setup.filetype(
  {"markdown", "help"},
  {
    sources = {
      {name = "path"},
      {name = "buffer"}
    }
  }
)
