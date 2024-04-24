-- Use the Space key as <Leader>. The leader can be used for custom mappings by
-- the user, or by plugins. It is primarily used in normal mode, in which the
-- Space key doesn't have a purpose. Using Space is convenient, as it is
-- located in the middle of the keyboard, and can be reached by both hands.
vim.g.mapleader = " "

-- When creating a (vertical) split, create this to the right or below of the
-- current buffer (instead of to the left or above). The benefit is that the
-- current buffer remains at the same place (and is not moved to the other part
-- of the screen), which is easier on the eyes and might be more intuitive.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- When this value is not set, a buffer that is "unloaded" when removed from
-- the view (when switching between buffers for example) is unloaded. One of
-- the results is that the undo history is discarded when a buffer is
-- temporarily not shown. Setting this value causes hidden buffers to remain in
-- existing in the background.
vim.opt.hidden = true

-- Don't give messages related to `ins-completion-menu` in the command line.
-- Examples are "match 1 of 2", "Pattern not found", etc. These messages don't
-- provide any additional information, while still being distracting.
vim.opt.shortmess:append { c = true }

-- When searching, ignore case unless the pattern contains upper case
-- characters. Apply the same setting when searching the tags file.
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tagcase = "followscs"

-- Apply folding by default using the "marker" method. This defaults to using
-- three curly braces to open and close a fold.
vim.opt.foldmethod = "marker"

-- Automatically reload the file if it has been changed outside of Vim.
vim.opt.autoread = true

-- Automatically save the current buffer. This prevents a lot of manual saving
-- and -- since most files are in version control -- is often safe to do. It
-- also prevents a lot of conflicts when you are modifying the same file
-- outside of Vim and have `autoread` enabled.
vim.opt.autowriteall = true

-- Configure `autoread` and `autowriteall` to work as expected. By default
-- these settings only trigger on certain actions, such as a shell command. By
-- shelling out every time you change your focus to/from Vim, or when entering
-- another buffer, your buffer is always saved to disk when you leave, and
-- reloaded when you come back.
vim.api.nvim_create_autocmd({ "FocusLost", "FocusGained", "BufEnter" }, { command = "silent! !" })

-- With the above autowrite and autoread in place, we can safely disable the
-- swap file.
vim.opt.swapfile = false
