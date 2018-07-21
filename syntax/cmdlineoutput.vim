" Vim syntax file
" Language:    No language. Output of any interpreter
" Maintainer:  Jakson Aquino <jalvesaq@gmail.com>


if exists('b:current_syntax')
    finish
endif

" Normal text
syn match cmdlineNormal "."

" Strings
if exists('b:syn_string_delimiter')
    for dlmtr in b:syn_string_delimiter
        exe 'syn region cmdlineString start=/' . dlmtr . '/ skip=/\\\\\|\\'
                    \ . dlmtr . '/ end=/' . dlmtr . '/ end=/$/'
    endfor
else
    syn region cmdlineString start=/"/ skip=/\\\\\|\\"/ end=/"/ end=/$/
endif

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

function s:SetColor(cgroup, hicolor, cgui, c256, c16)
    if exists('g:cmdline_color_' . a:hicolor)
        let hc = get(g:, 'cmdline_color_' . a:hicolor, '1')
        if hc =~? '^#[a-f0-9]\{6}$'
            exe 'hi cmdline' . a:cgroup . ' guifg=' . hc
        elseif hc =~# '^[0-9]*$'
            exe 'hi cmdline' . a:cgroup . ' ctermfg=' . hc
        else
            exe 'hi cmdline' . a:cgroup . ' ' . hc
        endif
    else
        if &t_Co == 256
            exe 'hi cmdline' . a:cgroup . ' ctermfg=' . a:c256 . ' guifg=' . a:cgui
        else
            exe 'hi cmdline' . a:cgroup . ' ctermfg=' . a:c16  . ' guifg=' . a:cgui
        endif
    endif
endfunction

" Change colors under user request:
call s:SetColor('Input',   'input',    '#9e9e9e',               '247',          'gray')
call s:SetColor('Normal',  'normal',   '#00d700',               '40',           'darkgreen')
call s:SetColor('Number',  'number',   '#ffaf00',               '214',          'darkyellow')
call s:SetColor('Integer', 'integer',  '#ffaf00',               '214',          'darkyellow')
call s:SetColor('Float',   'float',    '#ffaf00',               '214',          'darkyellow')
call s:SetColor('Complex', 'complex',  '#ffaf00',               '214',          'darkyellow')
call s:SetColor('NegNum',  'negnum',   '#ff875f',               '209',          'darkyellow')
call s:SetColor('NegFlt',  'negfloat', '#ff875f',               '209',          'darkyellow')
call s:SetColor('Date',    'date',     '#d7af5f',               '179',          'darkyellow')
call s:SetColor('False',   'false',    '#ff5f5f',               '203',          'darkyellow')
call s:SetColor('True',    'true',     '#5fd787',               '78',           'magenta')
call s:SetColor('Inf',     'inf',      '#00afff',               '39',           'darkgreen')
call s:SetColor('Const',   'constant', '#00af5f',               '35',           'magenta')
call s:SetColor('String',  'string',   '#5fffaf',               '85',           'darkcyan')
call s:SetColor('Error',   'error',    '#ffffff guibg=#c00000', '15 ctermbg=1', 'white ctermbg=red')
call s:SetColor('Warn',    'warn',     '#c00000',               '1',            'red')
call s:SetColor('Index',   'index',    '#87afaf',               '109',          'darkgreen')

delfunction s:SetColor

let   b:current_syntax = 'cmdline'

" vim: ts=8 sw=4
