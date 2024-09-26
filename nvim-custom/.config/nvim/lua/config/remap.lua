vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Buffer: Delete current buffer and then go to the next file
vim.keymap.set("n", "<leader>bd", function()
  vim.cmd("bp")
  vim.cmd("sp")
  vim.cmd("bn")
  vim.cmd("bd")
end, { noremap = true, silent = true })

-- Buffer: go to next/prev buffer
vim.keymap.set("n", "L", vim.cmd.bnext)
vim.keymap.set("n", "H", vim.cmd.bprevious)

-- Buffer: close all buffers except the current one

-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end)

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
  require("persistence").select()
end)

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end)

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
  require("persistence").stop()
end)
