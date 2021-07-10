--  This script uses "packer.nvim" to manage the specified plugins.

return require("packer").startup {
    function(use)
        -- Packer can manage itself. Omitting this will result in packer trying
        -- to remove itself, since its not specified in the configuration.
        use "wbthomason/packer.nvim"
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
