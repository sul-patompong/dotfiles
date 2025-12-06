return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet")({
          discovery_root = "solution", -- Use "solution" for .sln files, "project" for .csproj
        }),
      },
    })
  end,
}
