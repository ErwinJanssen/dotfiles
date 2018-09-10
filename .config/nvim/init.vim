" Set the text width, by default this proves auto wrapping
set textwidth=79
au FileType gitcommit set tw=72

" Enable mouse support
set mouse=a

""" Colors and visuals
" Make sure the theme is set for a dark background
set background=dark

" Underline spell errors
highlight clear SpellBad
highlight SpellBad cterm=underline

" Set both absolute and relative line numbers
set number
set relativenumber

" Set a color column to indicate text width
set colorcolumn=+1

" Show whitespace
set list

" Trim all trailing whitespace on buffer write
function! TrimWhitespace()
    let l:state = winsaveview()
    " Trim trailing whitespace on every line
    %substitute/\s\+$//e
    " Trim trailing empty lines at the end of the file
    %substitute/\($\n\)\+\%$//e
    call winrestview(l:state)
endfun

autocmd BufWritePre * call TrimWhitespace()

set spell spelllang=en_us

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg = 'DarkGray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

call plug#end()
