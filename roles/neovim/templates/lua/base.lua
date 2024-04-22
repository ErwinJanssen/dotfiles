-- Use the Space key as <Leader>. The leader can be used for custom mappings by
-- the user, or by plugins. It is primarily used in normal mode, in which the
-- Space key doesn't have a purpose. Using Space is convenient, as it is
-- located in the middle of the keyboard, and can be reached by both hands.
vim.g.mapleader = " "

-- When creating a (vertical) split, create this to the right or below of the
-- current buffer (instead of to the left or above). The benefit is that the
-- current buffer remains at the same place (and is not moved to the other part
-- of the screen), which is easier on the eyes and might be more intuitive.
vim.o.splitright = true
vim.o.splitbelow = true
