return {
  -- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = { transparent_mode = true } },
  -- { "rebelot/kanagawa.nvim", opts = { transparent = true, theme = "dragon" } },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { transparent_background = true } },
  {
    "savq/melange-nvim",
    name = "melange",
    priority = 1000,
    config = function()
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "melange",
    },
  },
}
