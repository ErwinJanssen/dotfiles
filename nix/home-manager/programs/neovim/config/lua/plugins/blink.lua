-- Configure auto completion using 'blink-cmp'

require("blink.cmp").setup {
    keymap = {
        -- Use Ctrl-Space to start auto-complete, or select the next entry.
        preset = "default",
        ["<C-Space>"] = {
            "show",
            "select_next",
        },
    },
    completion = {
        trigger = {
            -- When true, will show completion window after backspacing
            show_on_backspace = true,

            -- When true, will show the completion window after entering insert
            -- mode
            show_on_insert = true,

            -- When true, will show the completion window after typing a
            -- trigger character
            show_on_trigger_character = true,
        },
        list = {
            selection = {
                -- When `true`, will automatically select the first item in the
                -- completion list
                preselect = false,
            },
        },
        documentation = {
            -- Controls whether the documentation window will automatically
            -- show when selecting a completion item
            auto_show = true,
        },
    },
    sources = {
        providers = {
            lsp = {
                override = {
                    get_trigger_characters = function(self)
                        local trigger_characters = self:get_trigger_characters()

                        -- For LSP completion, always treat a period as
                        -- a trigger character.
                        vim.list_extend(trigger_characters, { "." })

                        return trigger_characters
                    end,
                },
            },
        },
    },
}
