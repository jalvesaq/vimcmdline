" Vim syntax file
" Language:    No language. Output of any interpreter
" Maintainer:  Jakson Aquino <jalvesaq@gmail.com>


if exists('b:current_syntax')
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
if exists('b:cmdline_prompt')
    exe 'syn match cmdlineInput ' . b:cmdline_prompt
endif
if exists('b:cmdline_continue')
    exe 'syn match cmdlineInput ' . b:cmdline_continue
endif

" Errors and warnings
if exists('b:cmdline_error')
    exe 'syn match cmdlineError ' . b:cmdline_error
endif
if exists('b:cmdline_warn')
    exe 'syn match cmdlineWarn ' . b:cmdline_warn
endif

hi def link cmdlineInput	Comment

if exists('g:cmdline_follow_colorscheme') && g:cmdline_follow_colorscheme
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
    hi def link cmdlineInf	Number
    hi def link cmdlineConst	Constant
    hi def link cmdlineString	String
    hi def link cmdlineIndex	Special
    hi def link cmdlineError	ErrorMsg
    hi def link cmdlineWarn	WarningMsg
    finish
endif

" Either GUI running or 'termguicolors'
hi cmdlineInput	guifg=#9e9e9e
hi cmdlineNormal	guifg=#00d700
hi cmdlineNumber	guifg=#ffaf00
hi cmdlineInteger	guifg=#ffaf00
hi cmdlineFloat	guifg=#ffaf00
hi cmdlineComplex	guifg=#ffaf00
hi cmdlineNegNum	guifg=#ff875f
hi cmdlineNegFlt	guifg=#ff875f
hi cmdlineDate	guifg=#d7af5f
hi cmdlineFalse	guifg=#ff5f5f
hi cmdlineTrue	guifg=#5fd787
hi cmdlineInf	guifg=#00afff
hi cmdlineConst	guifg=#00af5f
hi cmdlineString	guifg=#5fffaf
hi cmdlineError	guifg=#ffffff guibg=#c00000
hi cmdlineWarn	guifg=#c00000
hi cmdlineIndex	guifg=#87afaf

if &t_Co == 256
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
    hi cmdlineInf	ctermfg=39
    hi cmdlineConst	ctermfg=35
    hi cmdlineString	ctermfg=85
    hi cmdlineError	ctermfg=15 ctermbg=1
    hi cmdlineWarn	ctermfg=1
    hi cmdlineIndex	ctermfg=109
else
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

function s:SetColor(cgroup, hicolor)
    if exists('g:' . a:hicolor)
        let hc = get(g:, a:hicolor, '1')
        if hc =~? '^#[a-f0-9]\{6}$'
            let g:TheHiCmdGUI = 'hi ' . a:cgroup . ' guifg=' . hc
            exe 'hi ' . a:cgroup . ' guifg=' . hc
        elseif hc =~# '^[0-9]*$'
            let g:TheHiCmdTerm = 'hi ' . a:cgroup . ' ctermfg=' . hc
            exe 'hi ' . a:cgroup . ' ctermfg=' . hc
        else
            let g:TheHiCmd = 'hi ' . a:cgroup . ' ' . hc
            exe 'hi ' . a:cgroup . ' ' . hc
        endif
    endif
endfunction

" Change colors under user request:
call s:SetColor('cmdlineInput',   'cmdline_color_input')
call s:SetColor('cmdlineNormal',  'cmdline_color_normal')
call s:SetColor('cmdlineNumber',  'cmdline_color_number')
call s:SetColor('cmdlineInteger', 'cmdline_color_integer')
call s:SetColor('cmdlineFloat',   'cmdline_color_float')
call s:SetColor('cmdlineComplex', 'cmdline_color_complex')
call s:SetColor('cmdlineNegNum',  'cmdline_color_negnum')
call s:SetColor('cmdlineNegFlt',  'cmdline_color_negfloat')
call s:SetColor('cmdlineDate',    'cmdline_color_date')
call s:SetColor('cmdlineFalse',   'cmdline_color_false')
call s:SetColor('cmdlineTrue',    'cmdline_color_true')
call s:SetColor('cmdlineInf',     'cmdline_color_inf')
call s:SetColor('cmdlineConst',   'cmdline_color_constant')
call s:SetColor('cmdlineString',  'cmdline_color_string')
call s:SetColor('cmdlineError',   'cmdline_color_error')
call s:SetColor('cmdlineWarn',    'cmdline_color_warn')
call s:SetColor('cmdlineIndex',   'cmdline_color_index')

let   b:current_syntax = 'cmdline'

" vim: ts=8 sw=4
