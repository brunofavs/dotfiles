return{
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
	      "nvim-lua/plenary.nvim",
	      "nvim-tree/nvim-web-devicons",
	      "MunifTanjim/nui.nvim",},
	config = function()
		vim.keymap.set('n','<C-b>', '<Cmd>Neotree toggle<CR>',{})


    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
	          '.git',
	        },
        }
      },
      window = {
          mappings = {
          -- This shit was overwrittig my bind
          --https://github.com/nvim-neo-tree/neo-tree.nvim/blob/a981ef287503c668434bffa78071d5b9ff92c12f/lua/neo-tree/defaults.lua#L427
            ["<C-b>"] = "toggle" -- or "close_window"
          },
      },
    }

	end
}
