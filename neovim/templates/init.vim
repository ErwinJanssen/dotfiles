" ======================================
"            General settings
" ======================================

" Where to store plugins
let plugin_dir = '~/.local/share/nvim/plugged'

" Location of the Python virtual environment for Neovim
let g:python3_host_prog = '{{ neovim_virtualenv }}/bin/python'

" When creating a (vertical) split, create this to the right or below of the
" current buffer (instead of to the left or above). The benefit is that the
" current buffer remains at the same place (and is not moved to the other part
" of the screen), which is easier on the eyes and might be more intuitive.
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

" When searching, ignore case unless the pattern contains upper case
" characters. Apply the same setting when searching the tags file.
set ignorecase
set smartcase
set tagcase=followscs

" ======================================
"                 Plugins
" ======================================
call plug#begin(plugin_dir)

" Load plugins from the Vim system directory, this includes the `fzf` plugin.
Plug '/usr/share/vim/vimfiles/plugin/'

" Fuzzy search when pressing CTRL-P
Plug 'junegunn/fzf.vim'
noremap <C-P> :silent FZF<CR>

" Show Git diff in the signcolumn (added, removed, modified).
Plug 'airblade/vim-gitgutter'

" Lightweight status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='violet'

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg = 'DarkGray'

" When using Goyo, disable the signcolumn
autocmd! User GoyoEnter
    \ Limelight
    \ | set signcolumn=no
autocmd! User GoyoLeave
    \ Limelight!
    \ | set signcolumn=yes

" Better support for Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#folding#fdc = 0

" Auto completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 200

" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_settingsPath = '~/.config/nvim/language_client.json'

" Highlight the yanked region
Plug 'machakann/vim-highlightedyank'

" Lots of color schemes
Plug 'flazz/vim-colorschemes'
Plug 'drewtempelmeyer/palenight.vim'
let g:palenight_terminal_italics=1

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

" Always keep this amount of lines between the cursor and the edge of the
" window.
set scrolloff=5
set sidescrolloff=5

" Set the completion mode in the command line. With this setting, pressing
" <Tab> in the command line will complete till the longest common string
" and starts the wildmenu. Pressing <Tab> again will complete the next full
" match.
set wildmode=longest:full,full

" ======================================
"                 Visuals
" ======================================
" Use 24-bit colors if possible
if (has("termguicolors"))
      set termguicolors
  endif

" Make sure the theme is set for a dark background
set background=dark

" Highlight the line of the cursor
set cursorline

" Set a color column to indicate text width
set colorcolumn=+1

" Show whitespace
set list

" Set the colorscheme
colorscheme palenight

" Do not use the background provided by the colorscheme
highlight Normal ctermbg=NONE guibg={{ background }}

" Instead of coloring the entire word on a spelling mistake, only color the
" undercurl (in the same color as the color scheme).
let s:spell_defaults = 'ctermbg=NONE ctermfg=NONE cterm=UNDERCURL guibg=NONE guifg=NONE gui=UNDERCURL'
let g:palenight_colors = palenight#GetColors()

execute 'highlight SpellBad ' . s:spell_defaults . ' guisp=' palenight_colors.red.gui
execute 'highlight SpellCap ' . s:spell_defaults . ' guisp=' palenight_colors.dark_yellow.gui
execute 'highlight SpellLocal ' . s:spell_defaults . ' guisp=' palenight_colors.dark_yellow.gui
execute 'highlight SpellRare ' . s:spell_defaults . ' guisp=' palenight_colors.dark_yellow.gui

" ======================================
"                 Editor
" ======================================

" Enable mouse support
set mouse=a

" Delete previous/next word using ctrl-backspace/del, both in insert mode and
" on the command line.
function! DeleteNextWord()
    " If the cursor is on the end of the line, merge this line with the next.
    if col(".") >= col("$") - 1
        normal J
    " In all other cases, delete the next word
    else
        normal dw
    endif
endfun
noremap! <C-H> <C-W>
noremap! <C-Del> <C-O>:call DeleteNextWord()<CR>

" Make the arrows keys work as expected when the cursor is at the start or the
" end of a line, by moving the cursor to the previous or next line.
set whichwrap+=<,>,[,]

" Always insert spaces when inserting a <Tab>
set expandtab

" Default to 4 spaces indentation
set shiftwidth=4
set tabstop=4

" Use tab/shift-tab to indent/dedent visually selected blocks (and keep the
" area selected).
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Every wrapped line will have the same indentation as the beginning of the
" line.
set breakindent

" Set the text width to 79 characters, so the color column appears at row 80. A
" line length of 79 or 80 is often recommended by many style guides. Some file
" types (such as gitcommit) overwrite this setting.
set textwidth=79

" Provides a live preview of the effects of the `substitute` command. Instead
" of seeing the result only after executing `substitute`, it shows the effects
" incrementally as you type. This option does not use the additional split to
" view off-screen results, because it makes the screen jump up and down while
" typing.
set inccommand=nosplit

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

" When formatting text or joining lines, do no insert a double space after
" a period, or other sentence delimiters.
set nojoinspaces

" Enable spell checking, with en_US as the default language
set spell spelllang=en_us

" Disable spell checking words that are not capitalized for most files. For
" many file types, this clutters the interface as variable names (which are
" often not capitalized) at the start of a line get marked. This is also an
" issue for yaml files, where the keys are spell checked, but not capitalized.
" To re-enable checking for capitalization, unset this value and the default
" behavior will kick in: setlocal spellcapcheck&
set spellcapcheck=

" Trigger auto complete using ctrl-space in insert mode
inoremap <C-Space> <C-N>

" Shortcut to comment out blocks, lines, etc. It is enabled by the
" 'vim-commentary' plugin. Use CTRL-/ to comment out a line or selection,
" similar to most other editors. For some reason, Vim maps the `/` key to `_`,
" so that must be used in the mapping.
noremap <C-_> :Commentary<CR>

" Invoke the build/make step when pressing <F5>. This is similar to how tools
" as Visual Studio (Code) work. It is also the key used to refresh a window in
" a web browser. It uses the ':make' command, so 'makeprg' should be set the
" filetype plugin.
nnoremap <F5> :make<CR>

" ======================================
"              Miscellaneous
" ======================================

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

" Configure language client

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'python': ['{{ neovim_virtualenv }}/bin/pyls'],
    \ }

nnoremap <F6> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
