return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "Issafalcon/neotest-dotnet",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet")({
          discovery_root = "solution",
          dotnet_additional_args = {},
        }),
      },
    })
  end,
}
