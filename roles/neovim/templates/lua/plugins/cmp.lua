-- Configure auto completion using `nvim-cmp`

-- These settings are required for `nvim-cmp` to function correctly
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"

cmp.setup {
    mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
}
