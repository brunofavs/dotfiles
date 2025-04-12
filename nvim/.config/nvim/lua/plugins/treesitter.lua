-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	config = function()
-- 		require("nvim-treesitter.configs").setup({
-- 			highlight = { enable = true },
--       -- disable = { "latex"}
-- 		})
-- 	end,
-- }

return{
      "nvim-treesitter/nvim-treesitter",

    config = function () 
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "python","latex","markdown" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },  
          })
      end
   }

