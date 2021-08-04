-- Configure auto completion using 'nvim-compe'

-- These settings are required for 'compe' to function
vim.o.completeopt = "menuone,noselect"

require("compe").setup {
    enabled = true,
    preselect = "always",
    source = {
        path = true,
        nvim_lsp = true,

        -- Give the buffer source a lower priority, the other sources will
        -- likely provide more relevant suggestions.
        buffer = { priority = -1 },

        -- Give the spell source an even lower priority, it will likely be most
        -- useful if the other sources have nothing to suggest (e.g. text
        -- files, documentation, new variable names).
        spell = { priority = -2 },
    },
}
