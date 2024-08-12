-- ººººººººººººººººººººººººººººººººººººººº
-- 		Vim Commands
-- ººººººººººººººººººººººººººººººººººººººº

vim.cmd("set cmdheight=0")

-- Deleting goes into a trash registry, to not interfere with yanking registry
-- vim.cmd('nnoremap d "_d')
-- Moving half page down/up also centers cursor, to prevent having to search for the cursor
vim.cmd("noremap <C-d> <C-d>zz ")
vim.cmd("nnoremap <C-u> <C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Moves to first non whitespace instead of beggining of line
vim.cmd("map 0 ^")
vim.cmd("set nu!")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
--vim.cmd("set cmdheight=0")

-- Experimental
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

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- ººººººººººººººººººººººººººººººººººººººº
-- 		Auto commands
-- ººººººººººººººººººººººººººººººººººººººº

local autocmd = vim.api.nvim_create_autocmd

-- autocmd("VimEnter", {
--   command = ":silent !kitty @ set-spacing padding=0 margin=0",
-- })

autocmd("VimLeavePre", {
  command = ":Neotree close",
  -- command = ":Neotree close | :Undotree hide",
})

autocmd("FileType", {
    pattern = {"tex","txt"},
    callback = function()
        vim.opt_local.textwidth = 110
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})


