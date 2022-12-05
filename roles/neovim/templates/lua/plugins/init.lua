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
        -- Configure Neovim's built-in language server client
        use {
            "neovim/nvim-lspconfig",
            config = [[require("plugins.lspconfig")]],
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
