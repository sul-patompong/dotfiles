-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Hand <C-h/j/k/l> to vim-tmux-navigator. LazyVim's defaults bind these to
-- <C-w>{h,j,k,l} (vim-only window nav), which silently no-ops at split edges
-- instead of forwarding to tmux.
for _, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
  pcall(vim.keymap.del, "n", key)
end
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  { silent = true, desc = "Tmux/Vim Left" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>",  { silent = true, desc = "Tmux/Vim Down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>",    { silent = true, desc = "Tmux/Vim Up" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Tmux/Vim Right" })
