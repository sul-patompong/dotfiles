return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")
		nvimtree.setup({
			update_focused_file = {
				enable = true, -- Updates the tree when changing files in other buffers
				update_cwd = true, -- Change the tree root directory based on the current file
			},
			view = {
				side = "left", -- Tree will always open on the left side
				width = 50, -- Width of the tree
			},
			-- git = {
			--   enable = true, -- Show git status in the tree
			--   ignore = false, -- Do not hide ignored files
			-- },
			-- actions = {
			--   open_file = {
			--     quit_on_open = false, -- Keep nvim-tree open when you open a file
			--   },
			-- },
			-- renderer = {
			--   group_empty = true, -- Group empty directories together
			-- },
			-- hijack_netrw = true, -- Hijack netrw to use nvim-tree
			-- respect_buf_cwd = true, -- Respect the current working directory of the buffer
			-- diagnostics = {
			--   enable = true, -- Enable LSP diagnostics in the tree
			-- },
		})

		vim.g.loaded_netew = 1
		vim.g.loaded_netrePlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
	end,
}
