" Unset the current syntax so the TeX syntax can be included
unlet! b:current_syntax
syn include @tex syntax/tex.vim

" Highlight math blocks and inline math using TeX
syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" contains=@tex keepend
syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend

" Set the current syntax back to Markdown
let b:current_syntax = "markdown"
