return {
  -- { "npxbr/gruvbox.nvim", name = "gruvbox", priority = 1000 },
  -- { "savq/melange-nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
