-- This will run last in the setup process.
-- A good place for things that don't fit in the normal config locations.

-- Sync kitty tab title with current working directory
vim.fn.system(string.format("kitty @ set-tab-title %q", vim.fs.basename(vim.fn.getcwd())))

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    vim.fn.system(string.format("kitty @ set-tab-title %q", vim.fs.basename(vim.fn.getcwd())))
  end,
})
