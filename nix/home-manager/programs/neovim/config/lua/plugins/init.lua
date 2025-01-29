-- Configure plugins. Install is done by Nix Home Manager.

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

require("gitsigns").setup()
require("which-key").setup()

require("luasnip.loaders.from_vscode").lazy_load()

require "plugins.cmp"

require "plugins.treesitter"

require("mason").setup()

local mason_lspconfig = require "mason-lspconfig"

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
    -- The first entry (without a key) will be the default handler and will be
    -- called for each installed server that doesn't have a dedicated handler.
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

-- Plugin for writing and navigating Obsidian vaults
require("obsidian").setup {
    workspaces = {
        {
            -- The plugin requires that a workspace path is specified,
            -- otherwise it will give an error on Neovim startup.
            name = "personal",
            path = "~/workspace/private-notes/",
        },
    },
    ui = {
        -- Disable UI features for now, evaluate later.
        enable = false,
    },

    notes_subdir = "notes",
    daily_notes = {
        folder = "notes/dailies",
    },
}
