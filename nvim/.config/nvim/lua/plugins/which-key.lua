return{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 600
  end,

  config = function ()
    local wk = require("which-key")
    wk.setup(
    wk.register({
      ["<leader>"] = {
        s = {
          --name = "harpoon",
          b = {"Show buffers" },
        },
      },
    })
    )
  end
}
