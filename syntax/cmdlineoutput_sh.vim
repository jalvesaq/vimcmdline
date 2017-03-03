" Vim syntax file
" Language:    No language. Output additionals for sh

runtime syntax/cmdlineoutput.vim

" Input
syn match cmdlineInput "^\$ .*"
syn match cmdlineInput "^> .*"

" Errors and warnings
syn match cmdlineError "^sh: .*"
