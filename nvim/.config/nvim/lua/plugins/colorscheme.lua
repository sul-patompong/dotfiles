return {
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = { transparent_mode = true } },
  -- { "rebelot/kanagawa.nvim", opts = { transparent = true, theme = "dragon" } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.gruvbox_material_transparent_background = 2
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.g.gruvbox_material_menu_selection_background = "red"
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },
}
