return {
  -- {
  --   "neanias/everforest-nvim",
  --   config = function()
  --     require("everforest").setup({
  --       background = "hard",
  --       transparent_background_level = 2
  --     })
  --   end,
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = true,
      -- bold = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
