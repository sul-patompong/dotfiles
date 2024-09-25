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
          jest_test_discovery = false,
          jestCommand = "npm test --",
          jestConfigFile = function(file)
            if string.find(file, "/apps/") then
              local matched = string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
              return matched
            end

            return vim.fn.getcwd() .. "/jest.config.js"
          end,
          cwd = function(file)
            if string.find(file, "/apps/") then
              local matched = string.match(file, "(.-/[^/]+/)src")
              return matched
            end
            return vim.fn.getcwd()
          end,
          env = { CI = true },
        },
      },
    },
  },
}
