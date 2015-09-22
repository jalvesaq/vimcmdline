" Vim syntax file
" Language:    No language. Output additionals for swipl

runtime syntax/cmdlineoutput.vim

" Input
syn match cmdlineInput "^?-.*"

" Errors
syn match cmdlineError "^ERROR:.*"
