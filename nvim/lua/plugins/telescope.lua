return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    event = "BufRead",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Telescope Find Files",
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers<CR>",
        desc = "Find all opened buffers",
      },
      {
        "<leader>f/",
        "<cmd>Telescope live_grep<CR>",
        desc = "Live grep via telescope",
      },
      -- {
      --   "<C-d>",
      --   function()
      --     require("telescope.actions").delete_buffer()
      --   end,
      --   desc = "Delete buffer",
      -- },
    },
  },
}
