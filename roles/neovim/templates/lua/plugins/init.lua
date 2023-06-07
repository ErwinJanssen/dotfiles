--  This script uses "packer.nvim" to manage the specified plugins.

return require("packer").startup {
    function(use)
        -- Packer can manage itself. Omitting this will result in packer trying
        -- to remove itself, since its not specified in the configuration.
        use "wbthomason/packer.nvim"

        -- Show Git diff in the signcolumn (added, removed, modified).
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                require("gitsigns").setup()
            end,
        }

        use {
            "hrsh7th/nvim-compe",
            config = [[require("plugins.compe")]],
        }

        -- Install and manage LSP servers, linters, etc.
        use {
            "williamboman/mason.nvim",
            -- :MasonUpdate updates registry contents
            run = ":MasonUpdate",
        }

        -- Bridge between `mason` and `lspconfig`
        use "williamboman/mason-lspconfig.nvim"

        -- Configuration for Neovim's built-in language server client
        use "neovim/nvim-lspconfig"

        -- Setup `mason`
        require("mason").setup()

        -- Setup both `mason` and `lspconfig` via `mason-lspconfig`. Ensure
        -- certain packages are installed, and provide a setup handler that
        -- automatically registers language servers with `lspconfig`.
        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
        }
        require("mason-lspconfig").setup_handlers {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {}
            end,
        }

        -- Treesitter: more advanced syntax highlighting
        use {
            "nvim-treesitter/nvim-treesitter",
            -- Perform parser update in synchronous mode, so the headless
            -- update script will wait for completion.
            run = ":TSUpdateSync",
            config = [[require("plugins.treesitter")]],
        }
    end,
}
