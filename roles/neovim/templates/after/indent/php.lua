-- The standard PHP indent plugin that comes packaged with (Neo)Vim
-- (/usr/share/nvim/runtime/indent/php.vim), explicitly disables certain indent
-- settings. Instead, it sets a custom `indentexpr`, which doesn't seem to work
-- properly.
-- Disable this `indentexpr` and restore original behavior.
vim.o.indentexpr = nil
vim.o.autoindent = true
vim.o.smartindent = true

-- Change the width of a tab back to 4
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
