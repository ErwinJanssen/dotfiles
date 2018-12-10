" Set the text width, by default this proves auto wrapping
set textwidth=79
au FileType gitcommit set tw=72

" Enable mouse support
set mouse=a

""" Custom key bindings
" Delete previous/next word using ctrl-backspace/del
inoremap <C-H> <C-W>
inoremap <C-Del> <C-O>dw

""" Colors and visuals
" Make sure the theme is set for a dark background
set background=dark

" Underline spell errors
highlight clear SpellBad
highlight clear SpellLocal
highlight SpellBad cterm=underline
highlight SpellLocal ctermbg=darkblue

" Set both absolute and relative line numbers
set number
set relativenumber

" Set a color column to indicate text width
set colorcolumn=+1

" Show whitespace
set list

" Configure the Neovim Python virtual environment
let g:python3_host_prog = '/home/erwin/.config/nvim/venv/bin/python'

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

" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Optional dependencies for LanguageClient
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Better markdown support (also for math in markdown)
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_math = 1

call plug#end()

" Configure language client

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'python': ['/home/erwin/.config/nvim/venv/bin/pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
