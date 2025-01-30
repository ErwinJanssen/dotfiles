-- In additional to the global format options:
vim.opt_local.formatoptions:append {
    -- Auto-wrap text using 'textwidth'.
    t = true,

    -- Automatic formatting of paragraphs. Every time text is inserted or
    -- deleted the paragraph will be reformatted.
    a = true,
}

-- Enable checking for words that are not capitalized, by resetting it to the
-- default value.
vim.opt_local.spellcapcheck = vim.api.nvim_get_option_info("spellcapcheck").default
