return {
  "nvim-neotest/neotest",
  dependencies = {
    "marilari88/neotest-vitest",
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    adapters = {
      ["neotest-vitest"] = {
        vitestConfigFile = vim.fn.getcwd() .. "/vitest.unit.config.mts",
      },
    },
  },
}
