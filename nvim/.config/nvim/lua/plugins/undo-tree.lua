return{
  "mbbill/undotree",
  config = function ()


    local function openFocusUndoTree()
      vim.cmd.UndotreeToggle()
      vim.cmd.UndotreeFocus()
    end

    -- Doesn't focus by default, that's stupid
    -- vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    vim.keymap.set('n', '<leader>u', openFocusUndoTree)

    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true
  end
}
