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
    end,

    config = {
        display = {
            -- Configure packer to be non interactive. This means it won't ask
            -- for input for actions and these can therefore be run headless in
            -- the provision script.
            non_interactive = true,
        },
    },
}
