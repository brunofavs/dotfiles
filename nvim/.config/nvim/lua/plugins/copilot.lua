return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_filetypes = {
      markdown = false,
      tex = false,
    }
  end,
}
