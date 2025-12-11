return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
  },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
    table.insert(
      opts.adapters,
      require("neotest-dotnet")({
        discovery_root = "solution",
        dap = {
          adapter_name = "netcoredbg",
          args = {
            justMyCode = false,
          },
        },
      })
    )
  end,
}
