local whichkey_ok, whichkey = pcall(require, "which-key")

-- Mappings to mimic behavior from other programs
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Write buffer to current file" })

-- Mappings to [f]ind things
if whichkey_ok then
    whichkey.register {
        ["<leader>f"] = { name = "Find something" },
    }
end

vim.keymap.set("n", "<Leader>ff", "<cmd>Files<CR>", {
    desc = "Find file",
})

vim.keymap.set("n", "<Leader>fF", "<cmd>call FZFFindAllFiles()<CR>", {
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
