-- Rust tools
local opts = {
  tools = {
    -- rust-tools options
    -- automatically set inlay hints (type hints)
    -- There is an issue due to which the hints are not applied on the first
    -- opened file. For now, write to the file to trigger a reapplication of
    -- the hints or just run :RustSetInlayHints.
    -- default: true
    autoSetHints = true,
    -- whether to show hover actions inside the hover window
    -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
    -- default: true
    hover_with_actions = true,
    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,
    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,
    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = "CursorHold",
      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,
      -- whether to show variable name before type hints with the inlay hints or not
      -- default: false
      show_variable_name = false,
      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",
      -- whether to align to the lenght of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = "Comment"
    },
    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        {"╭", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╮", "FloatBorder"},
        {"│", "FloatBorder"},
        {"╯", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╰", "FloatBorder"},
        {"│", "FloatBorder"}
      },
      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false
    },
    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,
      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11"
      }
    }
  },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true
  }, -- rust-analyer options
  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb"
    }
  }
}

require("rust-tools").setup(opts)
-- vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * :lua require'lsp_extensions'.inlay_hints{ prefix = '=>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} } ]]
-- require "lsp_extensions".inlay_hints {
--   highlight = "Comment",
--   prefix = " > ",
--   aligned = false,
--   only_current_line = false,
--   enabled = {"ChainingHint"}
-- }
-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- emmet-ls
require "lspconfig/configs".ls_emmet = {
  default_config = {
    cmd = {"ls_emmet", "--stdio"},
    filetypes = {"html", "css", "scss", "vue"},
    root_dir = function(_)
      return vim.loop.cwd()
    end,
    settings = {}
  }
}
-- lua
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = "/home/herschel/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local langservers = {
  "html",
  "cssls",
  "tsserver",
  -- "ls_emmet",
  "emmet_ls",
  "gopls",
  "sumneko_lua",
  "volar", -- 特别注意需要在项目下安装typescript
  -- "pyright",
  -- "jedi_language_server",
  "pylsp",
  "tailwindcss",
  -- 'vuels',
  "rust_analyzer",
  "sqls"
}

for _, server in ipairs(langservers) do
  if server == "sumneko_lua" then
    require "lspconfig"[server].setup {
      capabilities = capabilities,
      on_attach = on_attach_callback,
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {"vim"}
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false
          }
        }
      }
    }
  elseif server == "gopls" then
    require "lspconfig"[server].setup {
      capabilities = capabilities,
      on_attach = on_attach_callback,
      cmd = {"gopls", "serve"},
      settings = {
        gopls = {
          analyses = {
            unusedparams = true
          },
          staticcheck = true
        }
      }
    }
  elseif server == "pyright" then
    require "lspconfig".pyright.setup {
      capabilities = capabilities,
      on_attach = function(client)
        client.server_capabilities.completionProvider = false
      end
    }
  elseif server == "zeta_note" then
    require "lspconfig".zeta_note.setup {
      capabilities = capabilities,
      on_attach = on_attach_callback,
      cmd = {"/usr/bin/zeta-note"}
    }
  elseif server == "emmet_ls" then
    require "lspconfig".emmet_ls.setup {
      capabilities = capabilities,
      filetypes = {"html", "css", "typescriptreact", "javascriptreact"}
    }
  elseif server == "rust_analyzer" then
    --require("rust-tools").setup()
    require "lspconfig".rust_analyzer.setup {
      on_attach = function(client)
        require "completion".on_attach(client)
      end,
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "self"
          },
          cargo = {
            loadOutDirsFromCheck = true
          },
          procMacro = {
            enable = true
          }
        }
      }
    }
    require("rust-tools").setup({})
  elseif server == "sqls" then
    require "lspconfig".sqls.setup {
      settings = {
        sqls = {
          connections = {
            -- {
            --   driver = "mysql",
            --   dataSourceName = "root:root@tcp(127.0.0.1:3306)/blog"
            -- },
            -- {
            --   driver = 'postgresql',
            --   dataSourceName = 'host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
            -- },
            {
              driver = "sqlite3",
              dataSourceName = "/home/herschel/rustProjects/blog-actix/blog.db"
            }
          }
        }
      }
    }
  else
    require "lspconfig"[server].setup {
      capabilities = capabilities,
      on_attach = on_attach_callback
    }
  end
end

-- gopls orded import function
function Goimports(timeout_ms)
  local context = {only = {"source.organizeImports"}}
  vim.validate {context = {context, "t", true}}

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then
    return
  end
  local actions = result[1].result
  if not actions then
    return
  end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

-- copy from gopls recently
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
-- Create autocmd
vim.api.nvim_command("autocmd BufWritePre *.go lua OrgImports(1000)")
vim.api.nvim_command("autocmd BufWritePre *.py lua vim.lsp.buf.format()")
vim.api.nvim_command("autocmd BufWritePre *.rs lua vim.lsp.buf.format(nil, 200)")

--fold
function on_attach_callback(client, bufnr)
  -- If you use completion-nvim/diagnostic-nvim, uncomment those two lines.
  -- require('diagnostic').on_attach()
  -- require('completion').on_attach()
  require("folding").on_attach()
  require "lsp_signature".on_attach(
    {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    },
    bufnr
  )
end
