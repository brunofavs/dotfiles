
-- ººººººººººººººººººººººººººººººººººººººº
-- 		Neovide
-- ººººººººººººººººººººººººººººººººººººººº

if vim.g.neovide then
  vim.g.neovide_transparency = 0.6
  vim.g.neovide_scale_factor = 1.1

  -- No animations
  -- vim.g.neovide_position_animation_length = 0
  -- vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  -- vim.g.neovide_cursor_animate_in_insert_mode = false
  -- vim.g.neovide_cursor_animate_command_line = false
  -- vim.g.neovide_scroll_animation_far_lines = 0
  -- vim.g.neovide_scroll_animation_length = 0.00


end
-- ººººººººººººººººººººººººººººººººººººººº
-- 		Vim Commands
-- ººººººººººººººººººººººººººººººººººººººº

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

vim.cmd("set cmdheight=0")

-- Deleting goes into a trash registry, to not interfere with yanking registry
-- vim.cmd('nnoremap d "_d')
-- Moving half page down/up also centers cursor, to prevent having to search for the cursor
vim.cmd("noremap <C-d> <C-d>zz ")
vim.cmd("nnoremap <C-u> <C-u>zz")
vim.cmd("vnoremap / <Esc>/\\%V")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Moves to first non whitespace instead of beggining of line
vim.cmd("map 0 ^")
vim.cmd("set nu!")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
--vim.cmd("set cmdheight=0")

-- expandtab converts tabs to spaces
-- tabstop defines how many whitespaces a tab \t is 
-- softtabstop defines how much \t a tab press is. With ts=2 and st=1, 2 Tab presses equal 1 \t, not very useful if expandtab is on.
-- shitfwidth governs << and >> keybinds
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.scrolloff = 10
vim.cmd("let g:python3_host_prog = '/usr/bin/python3'")
-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- In visual mode selects until end of line without \n
vim.keymap.set('v', '$', '$h')


vim.keymap.set('n', '<S-Up>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Up>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Down>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Up>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Down>', '<Down>', { noremap = true, silent = true })

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.opt.listchars = { eol = '⤶',
                      space = '✚',
                      -- Tabs are not set because of expand tab.
                      tab = '◀-▶'
                    }

-- ººººººººººººººººººººººººººººººººººººººº
--          Auto commands
-- ººººººººººººººººººººººººººººººººººººººº

local autocmd = vim.api.nvim_create_autocmd

-- autocmd("VimEnter", {
--   command = ":silent !kitty @ set-spacing padding=0 margin=0",
-- })
autocmd("VimLeavePre", {
  command = ":Neotree close",
  -- command = ":Neotree close | :Undotree hide",
})

-- autocmd("FileType", {
--     pattern = {"tex","txt","markdown"},
--     callback = function()
--         -- vim.opt_local.textwidth = 110
--         vim.opt_local.textwidth = 140
--         vim.opt_local.wrap = true
--         vim.opt_local.linebreak = true
--         vim.opt_local.formatoptions:append("ta")
--     end,
-- })
--
autocmd("FileType", {
    pattern = {"tex", "txt", "markdown"},
    callback = function()
        -- Calculate 80% of the current window width
        local winwidth = vim.api.nvim_win_get_width(0)
        vim.opt_local.textwidth = math.floor(winwidth * 0.9)  -- Set to 80% of the window width
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        -- vim.opt_local.formatoptions:append("t")
    end,
})


