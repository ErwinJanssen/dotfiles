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

vim.keymap.set("n", "<Leader>fb", function()
    require("telescope.builtin").buffers { ignore_current_buffer = true, sort_mru = true }
end, {
    desc = "Find buffer",
})

vim.keymap.set("n", "<Leader>fl", "<cmd>BLines<CR>", {
    desc = "Find line in current buffer",
})

vim.keymap.set("n", "<Leader>fL", "<cmd>Lines<CR>", {
    desc = "Find line in *any* buffer",
})

vim.keymap.set("n", "<Leader>fg", require("telescope.builtin").grep_string, {
    desc = "Find word under cursor with ripgrep",
})

vim.keymap.set("n", "<Leader>fG", function()
    require("telescope.builtin").grep_string { search = vim.fn.input "Search string: " }
end, { desc = "Find with ripgrep" })

vim.keymap.set("n", "<Leader>f*", function()
    require("telescope.builtin").builtin { include_extensions = true }
end, { desc = "Find Telescope pickers" })

vim.keymap.set("n", "<Leader>fr", require("telescope.builtin").resume, {
    desc = "Resume last Telescope picker",
})

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
-- [n]ote taking
-- ==============================
-- {{{

whichkey.add { { "<leader>n", group = "Note taking" } }

vim.keymap.set("n", "<Leader>nt", "<cmd>ObsidianToday<CR>", {
    desc = "Today's notes",
})

-- }}}

-- ==============================
-- [t]oggle menus and behavior
-- ==============================
-- {{{

whichkey.add { { "<leader>t", group = "Toggle menus/interfaces" } }

vim.keymap.set("n", "<Leader>tu", "<cmd>MundoToggle<CR>", {
    desc = "Undo tree",
})

vim.keymap.set("n", "<Leader>ta", function()
    -- Invert the value of the 'automatic formatting' flag.
    vim.opt_local.formatoptions:append {
        a = not vim.opt_local.formatoptions:get().a,
    }
end, {
    desc = "Toggle autoformat",
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

vim.keymap.set("n", "<Leader>vB", package.loaded.gitsigns.blame, {
    desc = "Blame of entire file",
})

vim.keymap.set("n", "<Leader>vp", package.loaded.gitsigns.preview_hunk, {
    desc = "Preview the hunk at the cursor position in a floating window.",
})

-- }}}
