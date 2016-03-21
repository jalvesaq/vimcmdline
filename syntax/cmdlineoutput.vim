" Vim syntax file
" Language:    No language. Output of any interpreter
" Maintainer:  Jakson Aquino <jalvesaq@gmail.com>


if exists("b:current_syntax")
    finish
endif 

" Normal text
syn match cmdlineNormal "."

" Strings
syn region cmdlineString start=/"/ skip=/\\\\\|\\"/ end=/"/ end=/$/

" integer
syn match cmdlineInteger "\<\d\+L"
syn match cmdlineInteger "\<0x\([0-9]\|[a-f]\|[A-F]\)\+L"
syn match cmdlineInteger "\<\d\+[Ee]+\=\d\+L"

" number with no fractional part or exponent
syn match cmdlineNumber "\<\d\+\>"
syn match cmdlineNegNum "-\<\d\+\>"
" hexadecimal number 
syn match cmdlineNumber "\<0x\([0-9]\|[a-f]\|[A-F]\)\+"

" floating point number with integer and fractional parts and optional exponent
syn match cmdlineFloat "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="
syn match cmdlineNegFlt "-\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="
" floating point number with no integer part and optional exponent
syn match cmdlineFloat "\<\.\d\+\([Ee][-+]\=\d\+\)\="
syn match cmdlineNegFlt "-\<\.\d\+\([Ee][-+]\=\d\+\)\="
" floating point number with no fractional part and optional exponent
syn match cmdlineFloat "\<\d\+[Ee][-+]\=\d\+"
syn match cmdlineNegFlt "-\<\d\+[Ee][-+]\=\d\+"

" complex number
syn match cmdlineComplex "\<\d\+i"
syn match cmdlineComplex "\<\d\++\d\+i"
syn match cmdlineComplex "\<0x\([0-9]\|[a-f]\|[A-F]\)\+i"
syn match cmdlineComplex "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\=i"
syn match cmdlineComplex "\<\.\d\+\([Ee][-+]\=\d\+\)\=i"
syn match cmdlineComplex "\<\d\+[Ee][-+]\=\d\+i"

" dates and times
syn match cmdlineDate "[0-9][0-9][0-9][0-9][-/][0-9][0-9][-/][0-9][-0-9]"
syn match cmdlineDate "[0-9][0-9][-/][0-9][0-9][-/][0-9][0-9][0-9][-0-9]"
syn match cmdlineDate "[0-9][0-9]:[0-9][0-9]:[0-9][-0-9]"

" Input
if exists("b:cmdline_prompt")
    execute 'syn match cmdlineInput ' . b:cmdline_prompt
endif
if exists("b:cmdline_continue")
    execute 'syn match cmdlineInput ' . b:cmdline_continue
endif

" Errors and warnings
if exists("b:cmdline_error")
    execute 'syn match cmdlineError ' . b:cmdline_error
endif
if exists("b:cmdline_warn")
    execute 'syn match cmdlineWarn ' . b:cmdline_warn
endif

hi def link cmdlineInput	Comment

if exists("g:cmdline_follow_colorscheme") && g:cmdline_follow_colorscheme
    " Default when following :colorscheme
    hi def link cmdlineNormal	Normal
    hi def link cmdlineNumber	Number
    hi def link cmdlineInteger	Number
    hi def link cmdlineFloat	Float
    hi def link cmdlineComplex	Number
    hi def link cmdlineNegNum	Number
    hi def link cmdlineNegFlt	Float
    hi def link cmdlineDate	Number
    hi def link cmdlineTrue	Boolean
    hi def link cmdlineFalse	Boolean
    hi def link cmdlineInf  	Number
    hi def link cmdlineConst	Constant
    hi def link cmdlineString	String
    hi def link cmdlineIndex	Special
    hi def link cmdlineError	ErrorMsg
    hi def link cmdlineWarn	WarningMsg
else
    if &t_Co == 256
        " Defalt 256 colors scheme for R output:
        hi cmdlineInput	ctermfg=247
        hi cmdlineNormal	ctermfg=40
        hi cmdlineNumber	ctermfg=214
        hi cmdlineInteger	ctermfg=214
        hi cmdlineFloat	ctermfg=214
        hi cmdlineComplex	ctermfg=214
        hi cmdlineNegNum	ctermfg=209
        hi cmdlineNegFlt	ctermfg=209
        hi cmdlineDate	ctermfg=179
        hi cmdlineFalse	ctermfg=203
        hi cmdlineTrue	ctermfg=78
        hi cmdlineInf      ctermfg=39
        hi cmdlineConst	ctermfg=35
        hi cmdlineString	ctermfg=85
        hi cmdlineError	ctermfg=15 ctermbg=1
        hi cmdlineWarn	ctermfg=1
        hi cmdlineIndex	ctermfg=109
    else
        " Defalt 16 colors scheme for R output:
        hi cmdlineInput	ctermfg=gray
        hi cmdlineNormal	ctermfg=darkgreen
        hi cmdlineNumber	ctermfg=darkyellow
        hi cmdlineInteger	ctermfg=darkyellow
        hi cmdlineFloat	ctermfg=darkyellow
        hi cmdlineComplex	ctermfg=darkyellow
        hi cmdlineNegNum	ctermfg=darkyellow
        hi cmdlineNegFlt	ctermfg=darkyellow
        hi cmdlineDate	ctermfg=darkyellow
        hi cmdlineInf	ctermfg=darkyellow
        hi cmdlineFalse	ctermfg=magenta
        hi cmdlineTrue	ctermfg=darkgreen
        hi cmdlineConst	ctermfg=magenta
        hi cmdlineString	ctermfg=darkcyan
        hi cmdlineError	ctermfg=white ctermbg=red
        hi cmdlineWarn	ctermfg=red
        hi cmdlineIndex	ctermfg=darkgreen
    endif

    " Change colors under user request:
    if exists("g:cmdline_color_input")
        execute "hi cmdlineInput ctermfg=" . g:cmdline_color_input
    endif
    if exists("g:cmdline_color_normal")
        execute "hi cmdlineNormal ctermfg=" . g:cmdline_color_normal
    endif
    if exists("g:cmdline_color_number")
        execute "hi cmdlineNumber ctermfg=" . g:cmdline_color_number
    endif
    if exists("g:cmdline_color_integer")
        execute "hi cmdlineInteger ctermfg=" . g:cmdline_color_integer
    endif
    if exists("g:cmdline_color_float")
        execute "hi cmdlineFloat ctermfg=" . g:cmdline_color_float
    endif
    if exists("g:cmdline_color_complex")
        execute "hi cmdlineComplex ctermfg=" . g:cmdline_color_complex
    endif
    if exists("g:cmdline_color_negnum")
        execute "hi cmdlineNegNum ctermfg=" . g:cmdline_color_negnum
    endif
    if exists("g:cmdline_color_negfloat")
        execute "hi cmdlineNegFlt ctermfg=" . g:cmdline_color_negfloat
    endif
    if exists("g:cmdline_color_date")
        execute "hi cmdlineDate ctermfg=" . g:cmdline_color_date
    endif
    if exists("g:cmdline_color_false")
        execute "hi cmdlineFalse ctermfg=" . g:cmdline_color_false
    endif
    if exists("g:cmdline_color_true")
        execute "hi cmdlineTrue ctermfg=" . g:cmdline_color_true
    endif
    if exists("g:cmdline_color_inf")
        execute "hi cmdlineInf ctermfg=" . g:cmdline_color_inf
    endif
    if exists("g:cmdline_color_constant")
        execute "hi cmdlineConst ctermfg=" . g:cmdline_color_constant
    endif
    if exists("g:cmdline_color_string")
        execute "hi cmdlineString ctermfg=" . g:cmdline_color_string
    endif
    if exists("g:cmdline_color_error")
        execute "hi cmdlineError ctermfg=" . g:cmdline_color_error
    endif
    if exists("g:cmdline_color_warn")
        execute "hi cmdlineWarn ctermfg=" . g:cmdline_color_warn
    endif
    if exists("g:cmdline_color_index")
        execute "hi cmdlineIndex ctermfg=" . g:cmdline_color_index
    endif
endif

let   b:current_syntax = "cmdline"

" vim: ts=8 sw=4
