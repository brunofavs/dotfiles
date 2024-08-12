return {
    {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()

-- ººººººººººººººººººººººººººººººººººººººº
--  	   Open Mulitple
-- ººººººººººººººººººººººººººººººººººººººº
-- * Not working
-- https://www.reddit.com/r/neovim/comments/r5c5m6/telescope_opening_up_multiplefile_selections_in/

  -- local telescope_custom_actions = {}
  --
  -- function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  --     local picker = action_state.get_current_picker(prompt_bufnr)
  --     local selected_entry = action_state.get_selected_entry()
  --     local num_selections = #picker:get_multi_selection()
  --     if not num_selections or num_selections <= 1 then
  --         actions.add_selection(prompt_bufnr)
  --     end
  --     actions.send_selected_to_qflist(prompt_bufnr)
  --     vim.cmd("cfdo " .. open_cmd)
  -- end
  -- function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  --     telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
  -- end
  -- function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
  --     telescope_custom_actions._multiopen(prompt_bufnr, "split")
  -- end
  -- function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
  --     telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
  -- end
  -- function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  --     telescope_custom_actions._multiopen(prompt_bufnr, "edit")
  -- end
  --
  -- require('telescope').setup({
  --     defaults = {
  --         mappings = {
  --             i = {
  --                 ["<ESC>"] = actions.close,
  --                 ["<C-J>"] = actions.move_selection_next,
  --                 ["<C-K>"] = actions.move_selection_previous,
  --                 ["<TAB>"] = actions.toggle_selection,
  --                 ["<C-TAB>"] = actions.toggle_selection + actions.move_selection_next,
  --                 ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
  --                 ["<CR>"] = telescope_custom_actions.multi_selection_open,
  --                 ["<C-V>"] = telescope_custom_actions.multi_selection_open_vsplit,
  --                 ["<C-S>"] = telescope_custom_actions.multi_selection_open_split,
  --                 ["<C-T>"] = telescope_custom_actions.multi_selection_open_tab,
  --                 ["<C-DOWN>"] = require('telescope.actions').cycle_history_next,
  --                 ["<C-UP>"] = require('telescope.actions').cycle_history_prev,
  --             },
  --             n = i,
  --         },
  --
  --    }
  -- })

-- ººººººººººººººººººººººººººººººººººººººº
--  	   Open Mulitple (end)
-- ººººººººººººººººººººººººººººººººººººººº
      local builtin = require("telescope.builtin")
      vim.keymap.set('n','<C-e>', builtin.find_files,{})
      -- TODO Change to <C-S-f> to match VSCode
      vim.keymap.set('n','<C-f>', builtin.live_grep,{})
      vim.keymap.set('n', '<leader>sb', builtin.buffers, {noremap = true})
    end
    },

    {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      }
      require("telescope").load_extension("ui-select")
      end
    }
	}
