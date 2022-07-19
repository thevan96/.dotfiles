local dap = require('dap')
local path = '/home/thevan96/.config/nvim-dap'

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { path .. '/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = path .. '/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input(
        'Path to executable: ',
        vim.fn.expand('%:p:h') .. '/', 'file'
      )
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      }
    },
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input(
        'Path to executable: ',
        vim.fn.expand('%:p:h') .. '/', 'file'
      )
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      }
    }
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
