return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sql_formatter" },
      ["javascript"] = { "prettier" },
      ["javascriptreact"] = { "prettier" },
      ["typescript"] = { "prettier" },
      ["typescriptreact"] = { "prettier" },
    },
    formatters = {
      sql_formatter = {
        args = { "--language", "postgresql", "--config", '{"keywordCase":"upper"}' },
      },
    },
  },
}
