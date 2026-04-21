-- return{
--       "nvim-treesitter/nvim-treesitter",
--
--     config = function () 
--         require("nvim-treesitter.configs").setup({
--             ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "python","latex","markdown" },
--             sync_install = false,
--             highlight = { enable = true },
--             indent = { enable = true },  
--           })
--       end
--    }
--


return{
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  -- For nvim 12.1 and above, you can specify the branch to use. For nvim 12.0 and below, you have to omit this line.
  branch = 'main',
}

