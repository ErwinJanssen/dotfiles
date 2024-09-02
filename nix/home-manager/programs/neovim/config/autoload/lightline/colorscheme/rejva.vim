" Fetch theme colors from the `theme` plugin.
lua vim.g.theme_colors = require("theme")

let s:base3 = '#c5c8c6'
let s:base2 = '#bababa'
let s:base1 = '#a0a0a0'
let s:base0 = '#909090'
let s:base00 = '#666666'
let s:base01 = '#555555'
let s:base02 = '#434343'
let s:base023 = '#303030'
let s:base03 = '#1d1f21'
let s:red = '#cc6666'
let s:orange = '#de935f'
let s:yellow = '#f0c674'
let s:green = '#b5bd68'
let s:cyan = '#8abeb7'
let s:blue = '#81a2be'
let s:magenta = '#b294bb'

let s:normal = {}
let s:normal.black = g:theme_colors.colors.normal.black
let s:normal.red = g:theme_colors.colors.normal.red
let s:normal.green = g:theme_colors.colors.normal.green
let s:normal.yellow = g:theme_colors.colors.normal.yellow
let s:normal.blue = g:theme_colors.colors.normal.blue
let s:normal.magenta = g:theme_colors.colors.normal.magenta
let s:normal.cyan = g:theme_colors.colors.normal.cyan
let s:normal.white = g:theme_colors.colors.normal.white

let s:dim = {}
let s:dim.black = g:theme_colors.colors.dim.black
let s:dim.red = g:theme_colors.colors.dim.red
let s:dim.green = g:theme_colors.colors.dim.green
let s:dim.blue = g:theme_colors.colors.dim.blue
let s:dim.magenta = g:theme_colors.colors.dim.magenta

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [
    \   [ s:dim.magenta, s:normal.magenta ],
    \   [ g:theme_colors.ui.status_bar.default.foreground , g:theme_colors.theme.brighter.background ]
    \ ]
let s:p.normal.middle = [
    \   [ g:theme_colors.ui.status_bar.default.foreground, g:theme_colors.ui.status_bar.default.background ]
    \ ]
let s:p.normal.right = copy(s:p.normal.left)

let s:p.inactive.right = [
    \   copy(s:p.normal.middle)[0],
    \   copy(s:p.normal.middle)[0],
    \ ]
let s:p.inactive.left = copy(s:p.inactive.right)

let s:p.insert.left = [
    \   [ s:dim.green, s:normal.green ],
    \   copy(s:p.normal.left[1]),
    \ ]
let s:p.insert.right = copy(s:p.insert.left)

let s:p.visual.left = [
    \   [ s:dim.blue, s:normal.blue],
    \   copy(s:p.normal.left[1]),
    \ ]
let s:p.visual.right = copy(s:p.visual.left)

let s:p.replace.left = [
    \   [ s:dim.red, s:normal.red],
    \   copy(s:p.normal.left[1]),
    \ ]
let s:p.replace.right = copy(s:p.replace.left)

let s:p.tabline.left = [ [ g:theme_colors.ui.status_bar.tab.foreground, g:theme_colors.ui.status_bar.tab.background ] ]
let s:p.tabline.tabsel = [ [ g:theme_colors.ui.status_bar.active.foreground, g:theme_colors.ui.status_bar.active.background ] ]
let s:p.tabline.right = copy(s:p.normal.right)

let s:p.normal.error = [ [ s:normal.red, g:theme_colors.theme.brighter.background ] ]
let s:p.normal.warning = [ [ s:normal.yellow, g:theme_colors.theme.brighter.background ] ]

let g:lightline#colorscheme#rejva#palette = lightline#colorscheme#fill(s:p)
