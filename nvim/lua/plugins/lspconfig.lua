return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "ts_ls", "tailwindcss" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "stylua", "prettier" },
      auto_update = true,
      run_on_start = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      local on_attach = function(client, bufnr)
        opts.buffer = bufnr

        opts.desc = "Show LSP References"
        keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Show docs"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      lspconfig["ts_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "javascript.jsx",
          "typescriptreact",
          "typescript.tsx",
        },
      })

      lspconfig["tailwindcss"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
        -- root_dir = function(fname)
        --   local git_root = lspconfig.util.find_git_ancestor(fname)
        --   if git_root then
        --     local finalPath = git_root .. "/apps/drill-aware/"
        --     print(finalPath)
        --     return finalPath
        --   end
        --   return nil
        -- end,
        -- root_dir = lspconfig.util.root_pattern(".git") .. "/apps/drill-aware/",
      })
    end,
  },
}
