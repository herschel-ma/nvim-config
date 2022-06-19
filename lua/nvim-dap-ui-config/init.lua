-- https://github.com/rcarriga/nvim-dap-ui

local dap = require("dap")
local dapui = require("dapui")

-- 初始化调试界面
dapui.setup {
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
        "watches"
      },
      size = 40,
      position = "left"
    },
    {
      elements = {
        "repl",
        "console"
      },
      size = 10,
      position = "bottom"
    }
  }
}

-- 如果开启或关闭调试，则自动打开或关闭调试界面
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  dap.repl.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
  dap.repl.close()
end
