-- Configure syntax highlighting using tree-sitter

require("nvim-treesitter.configs").setup {
    -- Enable syntax highlighting
    highlight = {
        enable = true,
        -- Disable tree-sitter highlighting for Git commit messages, as this
        -- does not include an indication for max subject length. Native syntax
        -- highlighting colors the characters of the subject line red after
        -- 50 characters.
        disable = { "gitcommit" },
    },
}
