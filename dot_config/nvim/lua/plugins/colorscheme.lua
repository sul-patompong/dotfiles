return {
  {
    "ellisonleao/gruvbox.nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = true,
        overrides = {
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
        },
      })

      vim.cmd.colorscheme("gruvbox")
    end,
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
}
