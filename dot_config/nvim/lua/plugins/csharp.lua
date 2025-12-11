return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "roslyn",
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
  -- Disable Omnisharp (use Roslyn instead)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = false,
      },
    },
  },
}
