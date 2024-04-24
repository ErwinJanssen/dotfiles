local whichkey_ok, whichkey = pcall(require, "which-key")

-- Mappings to mimic behavior from other programs
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Write buffer to current file" })

-- ==============================
-- [f]ind things
-- ==============================
-- {{{

if whichkey_ok then
    whichkey.register {
        ["<leader>f"] = { name = "Find something" },
    }
end

vim.keymap.set("n", "<Leader>ff", "<cmd>Files<CR>", {
    desc = "Find file",
})

vim.keymap.set("n", "<Leader>fF", function()
    -- Call fzf `Files` command, but append `--no-ignore` in order to find
    -- files that are ignored by default.
    local original_command = vim.fn.getenv "FZF_DEFAULT_COMMAND"
    vim.fn.setenv("FZF_DEFAULT_COMMAND", original_command .. " --no-ignore")
    vim.fn["fzf#vim#files"](0)
    vim.fn.setenv("FZF_DEFAULT_COMMAND", original_command)
end, {
    desc = "Find *any* file (including ignored)",
})

vim.keymap.set("n", "<Leader>fb", "<cmd>Buffers<CR>", {
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

-- }}}

-- ==============================
-- [l]anguage action
-- ==============================
-- {{{

if whichkey_ok then
    whichkey.register {
        ["<leader>l"] = { name = "Language actions (LSP)" },
    }
end

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

if whichkey_ok then
    whichkey.register {
        ["<leader>t"] = { name = "Toggle menus/interfaces" },
    }
end

vim.keymap.set("n", "<Leader>tu", "<cmd>MundoToggle<CR>", {
    desc = "Undo tree",
})

-- }}}

-- ==============================
-- [v]ersion control
-- ==============================
-- {{{

if whichkey_ok then
    whichkey.register {
        ["<leader>v"] = { name = "Version control info and actions" },
    }
end

vim.keymap.set("n", "<Leader>vb", function()
    package.loaded.gitsigns.blame_line { full = true }
end, {
    desc = "Blame of current line",
})

-- }}}
