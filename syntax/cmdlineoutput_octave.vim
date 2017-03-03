" Vim syntax file
" Language:    No language. Output additionals for octave

runtime syntax/cmdlineoutput.vim

" Input
syn match cmdlineInput "^octave:.*"

" Errors and warnings
syn match cmdlineError "^error:.*"
