" Vim syntax file
" Language:    No language. Output additionals for ghci

runtime syntax/cmdlineoutput.vim

" Input
syn match cmdlineInput "^Prelude>.*"

" Errors and warnings
syn match cmdlineError "^<interactive>:.*"
