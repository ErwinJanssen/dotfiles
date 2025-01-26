-- Configure auto completion using 'nvim-cmp'

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
    snippet = {
        -- It is required to specify specify a snippet engine (even if it is
        -- not used).
        expand = function(args)
            luasnip.lsp_expand(args.body)
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

        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    -- Expand snippet if one is selected.
                    luasnip.expand()
                elseif cmp.get_selected_entry() then
                    -- Insert the currently selected item.
                    cmp.confirm()
                else
                    -- If the menu is visible, but nothing is selected, perform
                    -- the fallback actions. The default fallback is to simply
                    -- insert a newline.
                    fallback()
                end
            else
                fallback()
            end
        end),

        -- Use Tab and Shift-Tab to jump through snippet placeholders.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "luasnip" },
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
