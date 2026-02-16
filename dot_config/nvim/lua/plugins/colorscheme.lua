return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        transparent_background_level = 2,
        on_highlights = function(hl, palette)
          hl.NormalFloat = { bg = palette.none }
          hl.FloatBorder = { bg = palette.none }
        end,
      })

      vim.cmd.colorscheme("everforest")
    end,
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "everforest" } },
}
