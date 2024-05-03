" Disable the signcolumn
setlocal signcolumn=no

" Move the window to the right of the screen
wincmd L

" Set the width of the window to match the text width
execute &textwidth . "wincmd |"

" Keep the width of the window the same when other windows are opened or
" closed.
set winfixwidth
