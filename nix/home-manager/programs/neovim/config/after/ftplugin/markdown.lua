-- In additional to the global format options:
vim.opt_local.formatoptions:append {
    -- Auto-wrap text using 'textwidth'.
    t = true,
}

-- Enable checking for words that are not capitalized, by resetting it to the
-- default value.
vim.opt_local.spellcapcheck = vim.api.nvim_get_option_info("spellcapcheck").default
