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

          -- Auto-detect DLL path and project directory
          local function find_dotnet_project()
            local cwd = vim.fn.getcwd()
            local csproj_files = vim.fn.globpath(cwd, "**/*.csproj", false, true)
            local candidates = {}

            for _, csproj in ipairs(csproj_files) do
              -- Skip test projects
              if not csproj:match("%.Tests%.csproj$") then
                local project_dir = vim.fn.fnamemodify(csproj, ":h")
                local project_name = vim.fn.fnamemodify(csproj, ":t:r")
                local dll_pattern = project_dir .. "/bin/Debug/net*/" .. project_name .. ".dll"
                local dlls = vim.fn.glob(dll_pattern, false, true)

                for _, dll in ipairs(dlls) do
                  table.insert(candidates, { dll = dll, dir = project_dir })
                end
              end
            end

            if #candidates == 1 then
              return candidates[1]
            elseif #candidates > 1 then
              local options = { "Select project:" }
              for i, c in ipairs(candidates) do
                table.insert(options, i .. ". " .. c.dll)
              end
              local choice = vim.fn.inputlist(options)
              if choice > 0 and choice <= #candidates then
                return candidates[choice]
              end
            end
            return nil
          end

          -- Cache the selected project for the session
          local selected_project = nil

          local function get_project()
            if not selected_project then
              selected_project = find_dotnet_project()
            end
            return selected_project
          end

          local function get_dll_path()
            local project = get_project()
            if project then
              return project.dll
            end
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
          end

          local function get_cwd()
            local project = get_project()
            if project then
              return project.dir
            end
            return vim.fn.getcwd()
          end

          dap.configurations.cs = {
            {
              type = "coreclr",
              name = "Launch (auto-detect)",
              request = "launch",
              program = get_dll_path,
              cwd = get_cwd,
              stopOnEntry = false,
              env = {
                ASPNETCORE_ENVIRONMENT = "Development",
                STAGE = "local",
                ASPNETCORE_URLS = "http://localhost:5000;https://localhost:5001",
              },
            },
            {
              type = "coreclr",
              name = "Launch (manual)",
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
