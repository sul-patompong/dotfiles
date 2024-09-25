return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = function(file)
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
            elseif string.find(file, "/apps/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
            end

            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          env = { CI = true },
          cwd = function(file)
            if string.find(file, "/apps/") then
              local matched = string.match(file, "(.-/[^/]+/)src")
              return matched
            end
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
  keys = {
    { "<leader>tr", "<cmd>Neotest run<CR>" },
    { "<leader>tt", "<cmd>Neotest run file<CR>" },
  },
}
