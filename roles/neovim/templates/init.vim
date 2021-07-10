" ======================================
"            General settings
" ======================================
" {{ "{{{" }}

" Use the Space key as <Leader>. The leader can be used for custom mappings by
" the user, or by plugins. It is primarily used in normal mode, in which the
" Space key doesn't have a purpose. Using Space is convenient, as it is located
" in the middle of the keyboard, and can be reached by both hands.
let mapleader = " "

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

" Apply folding by default using the "marker" method. This defaults to using
" three curly braces to open and close a fold.
set foldmethod=marker

" {{ "}}}" }}

" ======================================
"                 Plugins
" ======================================
" {{ "{{{" }}
lua require("plugins")

call plug#begin(plugin_dir)

" Load plugins from the Vim system directory, this includes the `fzf` plugin.
Plug '/usr/share/vim/vimfiles/plugin/'

" Fuzzy search when pressing CTRL-P
Plug 'junegunn/fzf.vim'
noremap <C-P> :silent FZF<CR>

" Show Git diff in the signcolumn (added, removed, modified).
Plug 'airblade/vim-gitgutter'

" Lightweight status line
Plug 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'rejva',
    \ 'active': {
    \   'right': [
    \       ['lineinfo'],
    \       ['percent'],
    \   ]
    \ }
  \ }

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
let g:pandoc#syntax#conceal#use = 0

" Disable all keyboard shortcuts provided by default by the Pandoc plugin, as
" well as the auto formatting (which overrides values such as `formatoptions`)
let g:pandoc#modules#disabled = ['formatting', 'keyboard']

" Completion framework
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Highlight the yanked region
Plug 'machakann/vim-highlightedyank'

" Lots of color schemes
Plug 'flazz/vim-colorschemes'
Plug 'drewtempelmeyer/palenight.vim'
let g:palenight_terminal_italics=1

" Semantic highlighting for Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Fish support
Plug 'dag/vim-fish'

" TOML support
Plug 'cespare/vim-toml'

" Visualize undo tree
Plug 'simnalamburt/vim-mundo'

" Allow for asynchronous build commands (such as :Make instead of :make), for
" nonblocking compilation. The 'vim-dispatch-neovim' plugin will allow
" 'vim-dispatch' to use the build-in Neovim terminal.
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" Highlight color definitions (e.g. #1b1b1b, DarkGray, hsl(20, 30%, 50%))
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

" {{ "}}}" }}

" ======================================
"             User interface
" ======================================
" {{ "{{{" }}

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

" Limit the height of the popup menu (used for completion suggestions) to 10
" lines. If this it not set, it has no limit and can therefore cover the entire
" height of the window.
set pumheight=10

" Set the default listing style of netrw (the build-in file explorer), to tree
" style listing.
let g:netrw_liststyle=3

" Do not show the mode in the command-line, as this is already shown in the
" status-line using a plugin.
set noshowmode

" {{ "}}}" }}

" ======================================
"                 Visuals
" ======================================
" {{ "{{{" }}

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
colorscheme rejva

" Highlight color definitions in their color
lua require'colorizer'.setup()

" {{ "}}}" }}

" ======================================
"                 Editor
" ======================================
" {{ "{{{" }}

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
inoremap <silent><expr> <C-Space>
            \ pumvisible() ? "\<C-n>" :
            \ coc#refresh()

" Use Enter to expand a snippet and ctrl-space to jump in snippets
inoremap <silent><expr> <cr>
            \ pumvisible() ? coc#_select_confirm() :
            \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = '<C-Space>'

" Shortcut to comment out blocks, lines, etc. It is enabled by the
" 'vim-commentary' plugin. Use CTRL-/ to comment out a line or selection,
" similar to most other editors. For some reason, Vim maps the `/` key to `_`,
" so that must be used in the mapping.
noremap <C-_> :Commentary<CR>

" Invoke the build/make step when pressing <F5>. This is similar to how tools
" as Visual Studio (Code) work. It is also the key used to refresh a window in
" a web browser, which will often be used if a web application is rebuild. It
" uses the ':Make' command from vim-dispatch, so 'makeprg' should be set the
" appropriate filetype plugin.
nnoremap <F5> :Make<CR>

" Alternatively, also invoke the build/make step through <Leader>r. The key 'r'
" is also to refresh a window a web browser through CTRL-r. This eliminates the
" need for the function key (which might be more difficult to reach, or
" a keyboard might not have the function keys). The mnemonic for this shortcut
" is 'run' or 'rebuild'.
nnoremap <Leader>r :Make<CR>

" `gb` is a popular mapping to list and search through the buffers. This
" mapping invokes the Buffers command from the fzf.vim plugin, which searches
" through the available buffers with FZF.
noremap gb :Buffers<CR>

" Remove search highlights by pressing the <Leader> key twice
nnoremap <Leader><Leader> :nohlsearch<CR>

" {{ "}}}" }}

" ======================================
"              Miscellaneous
" ======================================
" {{ "{{{" }}

" Work around the issue where Neovim fails to reset the shape of the cursor
" after closing: https://github.com/neovim/neovim/issues/4867
" Because the terminal is configured to use a bar blinking every second, we set
" it to that.
augroup ResetCursor
    autocmd!
    autocmd VimLeave * set guicursor=a:ver100-blinkon1
augroup END

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

" Show the highlight groups of the object under the cursor. Useful for
" debugging and creating syntax files and color schemes.
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set winblend=10

let $FZF_DEFAULT_OPTS .= ' --margin 1,2 --layout reverse'

function! FloatingFZF()
let width = min([float2nr(&columns * 0.8), 80])
let height = min([float2nr(&lines * 0.6), 20])
let opts = { 'relative': 'editor',
           \ 'row': (&lines - height) / 2,
           \ 'col': (&columns - width) / 2,
           \ 'width': width,
           \ 'height': height }

call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" {{ "}}}" }}
