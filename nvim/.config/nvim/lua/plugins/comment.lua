-- return {
--   "numToStr/Comment.nvim",
--   lazy = false,
--   config = function ()
--     require('Comment').setup()
--   end
-- }

return {
  "nvim-mini/mini.comment",
  lazy = false,
  config = function ()
    require('mini.comment').setup()
  end
}
