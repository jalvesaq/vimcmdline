" Vim syntax file
" Language:    No language. Output additionals for python

let b:syn_string_delimiter = ['"', "'"]

runtime syntax/cmdlineoutput.vim

" Input
syn match cmdlineInput "^>>>.*"
syn match cmdlineInput "^\.\.\..*"
