" vim:fdm=marker
" Vim Color File
" Name:       rejva.vim
" Maintainer: https://github.com/drewtempelmeyer/palenight.vim
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name="rejva"

" Fetch theme colors from the `theme` plugin.
lua vim.g.theme_colors = require("theme")

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/master/README.md >
" for more information.)
if !exists("g:rejva_termcolors")
  let g:rejva_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:rejva_terminal_italics")
  let g:rejva_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  if g:rejva_terminal_italics == 0
    if has_key(a:style, "cterm") && a:style["cterm"] == "italic"
      unlet a:style.cterm
    endif
    if has_key(a:style, "gui") && a:style["gui"] == "italic"
      unlet a:style.gui
    endif
  endif
  if g:rejva_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  endif
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

" public {{{

function! rejva#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:red = { "gui": g:theme_colors.colors.normal.red, "cterm": "1", "cterm16": "1" }
let s:light_red = { "gui": g:theme_colors.colors.bright.red, "cterm": "204", "cterm16": "1" }
let s:dark_red = { "gui": g:theme_colors.colors.dim.red, "cterm": "196", "cterm16": "9" }
let s:green = { "gui": g:theme_colors.colors.normal.green, "cterm": "2", "cterm16": "2" }
let s:yellow = { "gui": g:theme_colors.colors.normal.yellow, "cterm": "180", "cterm16": "3" }
let s:dark_yellow = { "gui": "#F78C6C", "cterm": "173", "cterm16": "11" }
let s:blue = { "gui": g:theme_colors.colors.normal.blue, "cterm": "39", "cterm16": "4" }
let s:purple = { "gui": g:theme_colors.colors.normal.magenta, "cterm": "5", "cterm16": "5" }
let s:cyan = { "gui": g:theme_colors.colors.normal.cyan, "cterm": "38", "cterm16": "6" }
let s:white = { "gui": g:theme_colors.colors.normal.white, "cterm": "145", "cterm16": "7" }
let s:black = { "gui": g:theme_colors.colors.normal.black, "cterm": "235", "cterm16": "0" }
let s:visual_black = { "gui": "NONE", "cterm": "NONE", "cterm16": "0" }
let s:comment_grey = { "gui": g:theme_colors.colors.grey.blue, "cterm": "59", "cterm16": "15" }
let s:gutter_fg_grey = { "gui": "#4B5263", "cterm": "238", "cterm16": "15" }
let s:cursor_grey = { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }
let s:visual_grey = { "gui": "#3E4452", "cterm": "237", "cterm16": "15" }
let s:menu_grey = { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }
let s:special_grey = { "gui": "#3B4048", "cterm": "238", "cterm16": "15" }
let s:vertsplit = { "gui": "#181A1F", "cterm": "59", "cterm16": "15" }

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:red }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple }) " any statement
call s:h("Conditional", { "fg": s:purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:purple }) " case, default, etc.
call s:h("Operator", { "fg": s:cyan }) " sizeof", "+", "*", etc.

lua << EOF
    vim.api.nvim_set_hl(0, 'Keyword', {
        ctermfg = "magenta",
        fg = vim.g.theme_colors.colors.normal.magenta,
    })
EOF

call s:h("Exception", { "fg": s:purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", {}) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h hitest.vim`) {{{

call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:black, "fg": s:yellow }) " diff mode: Changed text within a changed line
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).

lua << EOF
    vim.api.nvim_set_hl(0, 'Normal', {
        ctermbg = "NONE",
        ctermfg = "white",
        bg = vim.g.theme_colors.theme.normal.background,
        fg= vim.g.theme_colors.theme.normal.foreground,
    })

    vim.api.nvim_set_hl(0, 'NormalFloat', {
        bg = vim.g.theme_colors.theme.bright.background,
    })
EOF

call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "gui": "UNDERCURL", "cterm": "UNDERCURL", "sp": s:red }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "gui": "UNDERCURL", "cterm": "UNDERCURL", "sp": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "gui": "UNDERCURL", "cterm": "UNDERCURL", "sp": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "gui": "UNDERCURL", "cterm": "UNDERCURL", "sp": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("TabLine", { "fg": s:comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:visual_black, "bg": s:visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}


lua << EOF

local theme = require "theme"

local hightlight_defintions = {
    -- Default highlight groups (from `:help highlight-groups`) {{{

    -- Popup menu: Normal item.
    Pmenu = {
        bg = theme.ui.search.item.background,
        fg = theme.ui.search.item.foreground,
    },

    -- Popup menu: selected item.
    PmenuSel = {
        bg = theme.ui.search.selected.background,
        fg = theme.ui.search.selected.foreground,
    },

    -- Popup menu: scrollbar.
    PmenuSbar = { bg = theme.ui.search.selected.background },

    -- Popup menu: Thumb of the scrollbar.
    PmenuThumb = { bg = theme.ui.search.selected.foreground },

    -- }}}

    -- Diagnostic (from `:help diagnostic-highlights`) {{{
    DiagnosticError = { fg = theme.colors.grey.red },
    DiagnosticWarn = { fg = theme.colors.grey.yellow },
    DiagnosticInfo = { fg = theme.colors.grey.magenta },
    DiagnosticHint = { fg = theme.colors.grey.cyan },
    DiagnosticOk = { fg = theme.colors.grey.green },
    -- }}}

    -- Git {{{
    gitcommitUnmerged = { fg = theme.colors.normal.green },
    gitcommitOnBranch = {},
    gitcommitBranch = { fg = theme.colors.normal.purple },
    gitcommitDiscardedType = { fg = theme.colors.normal.red },
    gitcommitSelectedType = { fg = theme.colors.normal.green },
    gitcommitHeader = {},
    gitcommitUntrackedFile = { fg = theme.colors.normal.cyan },
    gitcommitDiscardedFile = { fg = theme.colors.normal.red },
    gitcommitSelectedFile = { fg = theme.colors.normal.green },
    gitcommitUnmergedFile = { fg = theme.colors.normal.yellow },
    gitcommitFile = {},
    gitcommitSummary = { link = "Normal" },
    gitcommitOverflow = { fg = theme.colors.normal.red },
    gitcommitNoBranch = { link = "gitcommitBranch" },
    gitcommitUntracked = { link = "gitcommitComment" },
    gitcommitDiscarded = { link = "gitcommitComment" },
    gitcommitSelected = { link = "gitcommitComment" },
    gitcommitDiscardedArrow = { link = "gitcommitDiscardedFile" },
    gitcommitSelectedArrow = { link = "gitcommitSelectedFile" },
    gitcommitUnmergedArrow = { link = "gitcommitUnmergedFile" },
    -- }}}

    -- Treesitter {{{
    ["@variable"] = { fg = theme.colors.normal.red },
    -- }}}

    -- Telescope {{{
    TelescopeSelection = { bg = theme.ui.search.selected.background },
    TelescopeSelectionCaret = {
        bg = theme.ui.search.selected.background,
        fg = theme.ui.search.selected.foreground,
    },
    TelescopeMatching = { fg = theme.ui.search.item.match },
    -- }}}
}

for group, opts in pairs(hightlight_defintions) do
    vim.api.nvim_set_hl(0, group, opts)
end

EOF
