return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        init_options = {
          maxTsServerMemory = 8192, -- Increase memory allocation
        },
        settings = {
          typescript = {
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },
    },
  },
}
