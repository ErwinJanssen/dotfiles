--  This script uses Paq to manage the specified plugins.

require("paq"):setup { verbose = true } {
    -- Let Paq manage itself
    "savq/paq-nvim",

    -- Lua library with additional function for Neovim, used by other packages
    "nvim-lua/plenary.nvim",

    -- Additional file types
    "pearofducks/ansible-vim", -- Ansible YAML
    "vim-pandoc/vim-pandoc", -- Pandoc filetype and utilities
    "vim-pandoc/vim-pandoc-syntax", -- Pandoc syntax highlight
    "aklt/plantuml-syntax", -- PlantUML

    -- Show Git diff in the signcolumn (added, removed, modified).
    "lewis6991/gitsigns.nvim",

    -- Display pop-up with possible key bindings
    "folke/which-key.nvim",

    -- Auto-completion during typing, uses various sources
    "hrsh7th/nvim-compe",

    -- Treesitter: more advanced syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdateSync",
    },

    -- Configuration for Neovim's built-in language server client
    "neovim/nvim-lspconfig",

    -- Install and manage LSP servers, linters, etc.
    {
        "williamboman/mason.nvim",
        -- :MasonUpdate updates registry contents
        run = ":MasonUpdate",
    },

    -- Bridge between `mason` and `lspconfig`
    "williamboman/mason-lspconfig.nvim",
}

-- vim-pandoc
vim.g["pandoc#folding#fdc"] = 0
vim.g["pandoc#syntax#conceal#use"] = 0

-- Disable all keyboard shortcuts provided by default by the Pandoc plugin, as
-- well as the auto formatting (which overrides values such as `formatoptions`)
vim.g["pandoc#modules#disabled"] = { "formatting", "keyboard" }

-- Run initialization for plugins if they are installed
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
    gitsigns.setup()
end

local whichkey_ok, whichkey = pcall(require, "wich-key")
if whichkey_ok then
    whichkey.setup()
end

local compe_ok, _ = pcall(require, "compe")
if compe_ok then
    require "plugins.compe"
end

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
