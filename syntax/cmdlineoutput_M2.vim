" Vim syntax file
" Language:    No language. Output additionals for M2

runtime syntax/cmdlineoutput.vim

" Input
syn match cmdlineInput "\v^i+\d+\s+:.*%(\n\s.*)*"

" Errors
syn match cmdlineError "\v<error:.*"
