" ======================================
"            General settings
" ======================================
lua require("base")

" ======================================
"                 Plugins
" ======================================
lua require("plugins")

" ======================================
"             User interface
" ======================================
" {{{

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

" }}}

" ======================================
"                 Visuals
" ======================================
" {{{

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

" Highlight the yanked region
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
augroup END

" }}}

" ======================================
"                 Editor
" ======================================
" {{{

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
noremap! <C-Del> <C-O>:call DeleteNextWord()<CR>

" Newer versions of Neovim correctly register the `<BS>` key, but older
" (Neo)vim versions and other tools such as tmux don't; instead the `<BS>` key
" is registered as `_`. Therefore two mappings must be added: the first works
" in Neovim directly, the other works when Neovim is started within a tmux
" session.
noremap! <C-H> <C-W>
noremap! <C-BS> <C-W>

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

" Shortcut to comment out blocks, lines, etc. It is enabled by the
" 'vim-commentary' plugin. Use CTRL-/ to comment out a line or selection,
" similar to most other editors.
"
" Newer versions of Neovim correctly register the `/` key, but older (Neo)vim
" versions and other tools such as tmux don't; instead the `/` key is
" registered as `_`. Therefore two mappings must be added: the first works in
" Neovim directly, the other works when Neovim is started within a tmux
" session.
noremap <C-/> :Commentary<CR>
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

" Remove search highlights by pressing the <Leader> key twice
nnoremap <Leader><Leader> :nohlsearch<CR>

" Trigger and cycle trough auto completion in insert mode using CTRL-Space.
inoremap <silent><expr> <C-Space>
    \ pumvisible() ? "\<C-n>" :
    \ compe#complete()

nnoremap <Leader>gd :lua vim .lsp.buf.definition()<CR>

lua require("mappings")

" }}}

" ======================================
"              Miscellaneous
" ======================================
" {{{

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
    " Trim trailing empty lines at the end of the file
    %substitute/\($\n\)\+\%$//e
    call winrestview(l:state)
endfun

autocmd BufWritePre * call TrimWhitespace()

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
let width = min([float2nr(&columns * 0.8), 200])
let height = min([float2nr(&lines * 0.6), 40])
let opts = { 'relative': 'editor',
           \ 'row': (&lines - height) / 2,
           \ 'col': (&columns - width) / 2,
           \ 'width': width,
           \ 'height': height }

call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" }}}
