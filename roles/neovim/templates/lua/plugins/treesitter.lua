-- Configure syntax highlighting using tree-sitter

require("nvim-treesitter.configs").setup {
    -- Install all parsers
    ensure_installed = "all",

    -- Enable syntax highlighting
    highlight = {
        enable = true,
        -- Enable both tree-sitter highlighting and Vim regex highlighting.
        -- Some reasons to do this:
        -- -    For some file types, this provides a better highlighting
        --      experience (e.g. Ansible configuration files in YAML that also
        --      contain Jinja2 templating).
        -- -    Another important reason is spell checking. Vim regex
        --      highlighting provides a `@NoSpell` annotation on highlight
        --      groups that prevent things like variable names from being
        --      marked as a spelling error. Tree-sitter doesn't support this,
        --      resulting in a lot of visual noise. Enabling Vim regex
        --      highlighting alongside tree-sitter prevents these issues.
        additional_vim_regex_highlighting = true,
    },
}
