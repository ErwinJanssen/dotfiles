local whichkey_ok, whichkey = pcall(require, "which-key")

-- Mappings to mimic behavior from other programs
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Write buffer to current file" })

-- ==============================
-- [f]ind things
-- ==============================
-- {{ "{{{" }}

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

-- {{ "}}}" }}
