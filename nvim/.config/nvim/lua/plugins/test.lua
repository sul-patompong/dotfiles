return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    opts = {
      discovery = {
        enabled = false,
      },
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          -- jestConfigFile = "custom.jest.config.js",
          -- args = function()
          --   return {
          --     "--no-coverage",
          --     "--testLocationInResults",
          --     "--verbose",
          --     "--json",
          --     "--outputFile=/var/folders/k2/543mxxhs4wg0t_6lllrxvjp80000gn/T/nvim.patompong/xyst5B/0.json",
          --     "--forceExit",
          --   }
          -- end,
          -- jest_test_discovery = false,
          jestConfigFile = function(file)
            print(file)
            if string.find(file, "/apps/") then
              local matched = string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
              print(matched)
              return matched
            end

            return vim.fn.getcwd() .. "/jest.config.js"
          end,
          cwd = function(file)
            if string.find(file, "/apps/") then
              local matched = string.match(file, "(.-/[^/]+/)src")
              print(matched)
              return matched
            end
            return vim.fn.getcwd()
          end,
          env = { CI = true },
          -- cwd = function(path)
          --   return vim.fn.getcwd()
          -- end,
        },
      },
    },
  },
}
