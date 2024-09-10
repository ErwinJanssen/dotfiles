local whichkey = require "which-key"

-- Mappings to mimic behavior from other programs
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Write buffer to current file" })

-- ==============================
-- [f]ind things
-- ==============================
-- {{{

whichkey.add { { "<leader>f", group = "Find something" } }

vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files, {
    desc = "Find file",
})

vim.keymap.set("n", "<Leader>fF", function()
    require("telescope.builtin").find_files { no_ignore = true }
end, {
    desc = "Find *any* file (including ignored)",
})

vim.keymap.set("n", "<Leader>fb", require("telescope.builtin").buffers, {
    desc = "Find buffer",
})

vim.keymap.set("n", "<Leader>fl", "<cmd>BLines<CR>", {
    desc = "Find line in current buffer",
})

vim.keymap.set("n", "<Leader>fL", "<cmd>Lines<CR>", {
    desc = "Find line in *any* buffer",
})

vim.keymap.set("n", "<Leader>fg", function()
    vim.cmd("Rg " .. vim.fn.input "Search string: ")
end, { desc = "Find with ripgrep" })

vim.keymap.set("n", "<Leader>f*", function()
    require("telescope.builtin").builtin { include_extensions = true }
end, { desc = "Find Telescope pickers" })

-- }}}

-- ==============================
-- [l]anguage action
-- ==============================
-- {{{

whichkey.add { { "<leader>l", group = "Language actions (LSP)" } }

vim.keymap.set("n", "<Leader>ld", function()
    vim.diagnostic.open_float()
end, {
    desc = "Show diagnostic under cursor",
})

vim.keymap.set("n", "<Leader>lr", function()
    vim.lsp.buf.rename()
end, {
    desc = "Rename current symbol",
})

-- }}}

-- ==============================
-- [t]oggle menus and interfaces
-- ==============================
-- {{{

whichkey.add { { "<leader>t", group = "Toggle menus/interfaces" } }

vim.keymap.set("n", "<Leader>tu", "<cmd>MundoToggle<CR>", {
    desc = "Undo tree",
})

-- }}}

-- ==============================
-- [v]ersion control
-- ==============================
-- {{{

whichkey.add { { "<leader>v", group = "Version control info and actions" } }

vim.keymap.set("n", "<Leader>vb", function()
    package.loaded.gitsigns.blame_line { full = true }
end, {
    desc = "Blame of current line",
})

-- }}}
