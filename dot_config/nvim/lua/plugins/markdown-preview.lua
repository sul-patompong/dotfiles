return {
  "selimacerbas/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  dependencies = { "selimacerbas/live-server.nvim" },
  config = function()
    require("markdown_preview").setup({
      port = 8421,
      open_browser = false,
      debounce_ms = 300,
    })
  end,
}
