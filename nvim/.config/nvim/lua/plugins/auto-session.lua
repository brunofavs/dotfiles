return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>ss", "<cmd>AutoSession search<CR>", desc = "Session search" },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        -- pre_save_cmds = {":Neotree close<CR>"},
        -- auto_clean_after_session_restore = true
        auto_save = true,
        auto_restore = true,
 
  },
}
