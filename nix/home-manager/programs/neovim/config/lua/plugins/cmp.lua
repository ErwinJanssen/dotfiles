-- Configure auto completion using 'nvim-cmp'

local cmp = require "cmp"

cmp.setup {
    snippet = {
        -- It is required to specify specify a snippet engine (even if it is
        -- not used).
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
        -- Use Ctrl-Space to start auto-complete, or select the next entry.
        ["<C-Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete()
            end
        end, { "i", "s" }),

        -- Use 'Enter' to insert the currently selected item. The option
        -- `select = false` is used to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = false },
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        {
            name = "spell",
            options = {
                -- Only enable this source in a `@spell` treesitter capture.
                enable_in_context = function(params)
                    return require("cmp.config.context").in_treesitter_capture "spell"
                end,
            },
        },
    },
}
