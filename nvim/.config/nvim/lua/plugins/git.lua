return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {noremap = true})
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {noremap = true})
    end,
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "9seconds/repolink.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    cmd = {
      "Repolink"
    },
    config = function ()
      require("repolink").setup({
        -- Without this one the issues the markdown doesn't render the graphic box
        use_full_commit_hash = true
      })
    end
  }
}
