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
local sumneko_root_path = "/home/herschel/.config/nvim/lua/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local langservers = {
  "html",
  "cssls",
  "tsserver",
  "ls_emmet",
  "gopls",
  "sumneko_lua",
  "volar", -- 特别注意需要在项目下安装typescript
  -- "pyright",
  -- "jedi_language_server",
  "pylsp",
  "tailwindcss"
  -- 'vuels',
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
      on_attach = on_attach_callback,
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
  else
    require "lspconfig"[server].setup {
      capabilities = capabilities,
      on_attach = on_attach_callback
    }
  end
end

-- gopls orded import function
function goimports(timeout_ms)
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
-- Create autocmd
vim.api.nvim_command("autocmd BufWritePre *.go lua goimports(1000)")
vim.api.nvim_command("autocmd BufWritePre *.py lua vim.lsp.buf.formatting()")

--fold
function on_attach_callback(client, bufnr)
  -- If you use completion-nvim/diagnostic-nvim, uncomment those two lines.
  -- require('diagnostic').on_attach()
  -- require('completion').on_attach()
  require("folding").on_attach()
end