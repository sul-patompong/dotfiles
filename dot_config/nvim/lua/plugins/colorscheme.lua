return {
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Apply transparency after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "FloatTitle",
            "SignColumn",
            "EndOfBuffer",
            "MsgArea",
            "VertSplit",
            "WinSeparator",
            "StatusLine",
            "StatusLineNC",
            "TabLine",
            "TabLineFill",
            "LineNr",
            "CursorLineNr",
            "Folded",
            "FoldColumn",
            "NonText",
            "SpecialKey",
            "Pmenu",
            "PmenuSbar",
            -- NeoTree
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NeoTreeEndOfBuffer",
            "NeoTreeWinSeparator",
            -- Telescope
            "TelescopeNormal",
            "TelescopeBorder",
            "TelescopePromptNormal",
            "TelescopePromptBorder",
            "TelescopeResultsNormal",
            "TelescopeResultsBorder",
            "TelescopePreviewNormal",
            "TelescopePreviewBorder",
            -- WhichKey
            "WhichKeyFloat",
            -- Notify
            "NotifyBackground",
            -- Noice
            "NoiceCmdlinePopup",
            "NoiceCmdlinePopupBorder",
          }

          for _, group in ipairs(groups) do
            local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
            if ok then
              hl.bg = "NONE"
              hl.ctermbg = "NONE"
              vim.api.nvim_set_hl(0, group, hl)
            else
              vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
            end
          end
        end,
      })

      vim.cmd.colorscheme("melange")
    end,
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "melange" } },
}
