" ======================================
"            General settings
" ======================================

" Where to store plugins
let plugin_dir = '~/.local/share/nvim/plugged'

" Set the default position of a new window when splitting.
set splitright
set splitbelow

" Automatically save the current buffer, also when leaving Vim (`autowrite`
" does not always detect this). This prevents a lot of manual saving and, since
" most files are in version control, is often safe to do. It also prevents a
" lot of conflicts when you are modifying the same file outside of Vim and have
" `autoread` enabled.
set autowriteall
autocmd FocusLost * :silent! !

" Configure `autoread` to work as expected. By default `autoread` only triggers
" on certain actions, such as a shell command. By shelling out every time you
" enter a buffer or come back to Vim, your buffer gets refreshed with the
" contents from the disk.
set autoread
autocmd FocusGained,BufEnter * :silent! !

" With the above autowrite and autoread in place, we can safely disable the
" swap file.
set noswapfile

" ======================================
"                 Plugins
" ======================================
call plug#begin(plugin_dir)

" Show Git diff in the signcolumn (added, removed, modified).
Plug 'airblade/vim-gitgutter'

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg = 'DarkGray'
autocmd! User GoyoEnter
    \ Limelight
    \ | set signcolumn=no
autocmd! User GoyoLeave
    \ Limelight!
    \ | set signcolumn=yes

" Auto completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_settingsPath = '~/.config/nvim/language_client.json'

" Optional dependencies for LanguageClient
Plug 'junegunn/fzf'

" Lots of color schemes
Plug 'flazz/vim-colorschemes'

" Semantic highlighting for Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

call plug#end()

" ======================================
"             User interface
" ======================================

" Display both absolute and relative line numbers
set number
set relativenumber

" Always open the signcolumn (aka, the "gutter"), so the editor window does not
" jump every time the signcolumn (dis)appears.
set signcolumn=yes

" ======================================
"                 Editor
" ======================================

" Always insert spaces when inserting a <Tab>
set expandtab

" Default to 4 spaces indentation
set shiftwidth=4
set tabstop=4

" Set the text width to 79 characters, so the color column appears at row 80. A
" line length of 79 or 80 is often recommended by many style guides. Some file
" types (such as gitcommit) overwrite this setting.
set textwidth=79

" These format options determine how automatic formatting is done. More
" information van be found at `:help fo-table`, and relevant information is
" repeated below:
" c     Auto-wrap comments (but not source code) using `textwidth`.
" r,o   Insert comment leader when inserting a new line.
" q     Allow formatting of comments with `gq`.
" n     Recognize lists when formatting (uses `formatlistpat` for detection).
" 1     Don't break after a one-letter word, but before if possible.
" j     Remove the comment leader when joining lines.
set formatoptions=c,r,o,q,n,1,j

" Disable spell checking words that are not capitalized for most files. For
" many file types, this clutters the interface as variable names (which are
" often not capitalized) at the start of a line get marked. This is also an
" issue for yaml files, where the keys are spell checked, but not capitalized.
" To re-enable checking for capitalization, unset this value and the default
" behavior will kick in: setlocal spellcapcheck&
set spellcapcheck=

" ======================================
"              Miscellaneous
" ======================================

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

" Set a color column to indicate text width
set colorcolumn=+1

" Show whitespace
set list

" Configure the Neovim Python virtual environment
let g:python3_host_prog = '{{neovim_virtualenv }}/bin/python'

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

" Configure language client

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'python': ['{{ neovim_virtualenv }}/bin/pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
