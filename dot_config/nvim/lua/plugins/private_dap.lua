return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "coreclr" },
      handlers = {
        coreclr = function(config)
          local dap = require("dap")
          local adapter = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
            args = { "--interpreter=vscode" },
          }
          dap.adapters.coreclr = adapter
          dap.adapters.netcoredbg = adapter

          dap.configurations.cs = {
            {
              type = "coreclr",
              name = "Launch",
              request = "launch",
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
            {
              type = "coreclr",
              name = "Attach",
              request = "attach",
              processId = function()
                return require("dap.utils").pick_process()
              end,
            },
          }
        end,
      },
    },
  },
}
