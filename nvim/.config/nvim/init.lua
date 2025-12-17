-- ººººººººººººººººººººººººººººººººººººººº
--  	   Lazy Package Manager
-- ººººººººººººººººººººººººººººººººººººººº

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- ººººººººººººººººººººººººººººººººººººººº
--  	   Require files
-- ººººººººººººººººººººººººººººººººººººººº

require("vim-options")
require("lazy").setup("plugins")

-- ººººººººººººººººººººººººººººººººººººººº
--  	   LSP's
-- ººººººººººººººººººººººººººººººººººººººº
--
-- https://www.reddit.com/r/neovim/comments/1jw0zav/psa_heres_a_quick_guide_to_using_the_new_built_in/
vim.lsp.enable('luals')
vim.lsp.enable('pyright')
vim.lsp.enable('ltex')
vim.lsp.enable('docker_language_server')
-- Needs spellcheck installed. https://github.com/bash-lsp/bash-language-server
vim.lsp.enable('bashls')
vim.lsp.enable('html')
vim.lsp.enable('css_variables')
vim.lsp.enable('ts_ls')

-- The name inside '' has to match the one in 
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- The name of the file in ./lsp/ also has to match it

