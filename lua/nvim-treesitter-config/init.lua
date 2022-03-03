vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
      underline = true,
      virtual_text = {
          spacing = 5,
          severity_limit = 'Warning',
      },
      update_in_insert = true,
  }
)

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"html", "javascript", "lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  -- autotag
  autotag = {
    enable = true,
  },

  -- rainbow
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }, 

  -- autopairs
  autopairs = { enable = true },
}