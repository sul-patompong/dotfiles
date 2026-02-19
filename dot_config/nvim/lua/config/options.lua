-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure dotnet is in PATH for neotest-dotnet
vim.env.PATH = "/usr/local/share/dotnet:" .. vim.env.PATH

-- LazyVim disables clipboard over SSH; re-enable it (OSC 52 handles the rest)
vim.opt.clipboard = "unnamedplus"
