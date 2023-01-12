-- The recommended line length of gitcommit messages is 72 characters
vim.opt_local.textwidth = 72

-- Change the width of a tab back to 4, as specified in the main configuration
vim.opt_local.shiftwidth = vim.opt_global.shiftwidth:get()
vim.opt_local.tabstop = vim.opt_global.tabstop:get()
