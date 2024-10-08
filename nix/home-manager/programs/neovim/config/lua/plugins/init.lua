-- Configure plugins. Install is done by Nix Home Manager.

-- vim-pandoc
vim.g["pandoc#folding#fdc"] = 0
vim.g["pandoc#syntax#conceal#use"] = 0

-- Disable all keyboard shortcuts provided by default by the Pandoc plugin, as
-- well as the auto formatting (which overrides values such as `formatoptions`)
vim.g["pandoc#modules#disabled"] = { "formatting", "keyboard" }

-- Lightline
vim.g.lightline = {
    colorscheme = "rejva",
    active = {
        right = {
            { "lineinfo" },
            { "percent" },
        },
    },
}

-- Telescope
require("telescope").setup {
    defaults = {
        layout_config = {
            horizontal = { prompt_position = "top" },
        },
        sorting_strategy = "ascending",
        mappings = {
            i = {
                -- Close Telescope when pressing Escape while in insert,
                -- instead of returning to 'normal' mode and requiring an
                -- additional Escape to exit.
                ["<esc>"] = require("telescope.actions").close,
            },
        },
    },
}

-- Run initialization for plugins if they are installed
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
    gitsigns.setup()
end

local whichkey_ok, whichkey = pcall(require, "wich-key")
if whichkey_ok then
    whichkey.setup()
end

require "plugins.cmp"

local treesitter_ok, _ = pcall(require, "nvim-treesitter.configs")
if treesitter_ok then
    require "plugins.treesitter"
end

local mason_ok, mason = pcall(require, "mason")
if mason_ok then
    mason.setup()
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_ok then
    -- Setup both `mason` and `lspconfig` via `mason-lspconfig`. Ensure certain
    -- packages are installed, and provide a setup handler that automatically
    -- registers language servers with `lspconfig`.
    mason_lspconfig.setup {
        ensure_installed = {
            "ansiblels",
            "bashls",
            "lua_ls",
            "nil_ls",
            "pyright",
            "rust_analyzer",
        },
    }
    mason_lspconfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
    }

    -- Language specific configurations
    require("lspconfig").lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    -- Suppress "Undefined global `vim`" error
                    globals = { "vim" },
                },
            },
        },
    }
end
